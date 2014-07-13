window.Conversation = (function() {
  "use strict";

  var board, conversation, conversationUrl;

  function setLikeStatus(buttonElement, liked) {
    buttonElement.data("liked", liked);
    buttonElement.toggleClass("oneup-voted");
    buttonElement.text( (liked) ? "Undo" : "+1UP" );
  }

  return {
    // Called by the script in the head in order to set the board and conversation
    // id. This is necessary for some functions
    initialize: function(boardId, conversationId) {
      board = boardId;
      conversation = conversationId;
      conversationUrl = "/boards/" + board + "/conversations/" + conversation;
    },

    // adds ajax events to all 1ups
    ajaxLikes: function() {
      $(".oneup-button-clear").click(function(e) {
        e.preventDefault();

        var element = $(this);
        var postUrl = conversationUrl + "/posts/" + element.data("id");
        var liked = element.data("liked");
        var suffix = (liked) ? "/unlike" : "/like";

        // Let's be optimistic
        setLikeStatus(element, !liked);

        $.ajax(postUrl + suffix, {
          dataType: "json",
          error: function(data) {
            // It failed, show an error and then reset the button
            alert("Failed to change this post's like status. Please try again later.");
            setLikeStatus(element, liked);
          }
        });

        return false;
      });
    },

    quotePost: function (id) {
      var postAuthor = $("#post-author-" + id).attr("data-post-author");
      var postContent = $("#post-content-" + id).attr("data-post-content");
      var textarea = $('#reply-textarea');

      textarea.val(textarea.val() + "[quote=" + postAuthor + "]" + postContent + "[/quote]");
      textarea.focus();
    },

    likePost: function (linkElement, id) {
      event.preventDefault();

      // prevent the normal link from working if javascript is enabled
      return false;
    }
  };
})();
