// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require turbolinks
//= require jquery.turbolinks
//= require jquery.dropdown
//= require jquery.exptextarea
//= require mousetrap

// allow styles to target javascript users
$('html').removeClass('no-js');
$('html').addClass('js');

$(document).ready(function() {
  // Automatically expand textareas with class auto-expand
  $("textarea.auto-expand").expandingTextArea();

  // Sends user to the top of the page if they tap the
  // header background
  $('#header-background').bind('click', function (evt) {
    if(evt.target == $('#header-background')[0]) {
      window.scrollTo(0,0);
    }
  });
});

// Hide and show the loading gif for turbolinks changes
// TODO: Make it only show up if the page has taken
// ~500 milliseconds to load.
$(document).on('page:fetch', function() {
  $('#wtf-logo').hide();
  $('#loading').show();
});
$(document).on('page:change', function() {
  $('#wtf-logo').show();
  $('#loading').hide();
});

$(document).ready(function() {
  /* Add keyboard shortcut to go to PREVIOUS page */
  Mousetrap.bind('left', function() {
    if($("#left-navigation a.post-buttons").width() > 0) {
      window.location = $("#left-navigation a.post-buttons").attr("href");
    }
    if($("a.nav-left").width() > 0) {
      window.location = $("a.nav-left").attr("href");
    }
    return false;
  });

  /* Add keyboard shortcut to go to NEXT page */
  Mousetrap.bind('right', function() {
    if($("#right-navigation a.post-buttons").width() > 0) {
      window.location = $("#right-navigation a.post-buttons").attr("href");
    }
    if($("a.nav-right").width() > 0) {
      window.location = $("a.nav-right").attr("href");
    }
    return false;
  });
});