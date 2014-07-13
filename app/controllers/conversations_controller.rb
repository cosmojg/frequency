class ConversationsController < ApplicationController
  include UpdatesUnread

  load_and_authorize_resource :board
  load_and_authorize_resource :conversation, through: :board

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    # Remove any unread statuses that have anything to do with this topic
    if current_user
      UnreadState.where(user_id: current_user,
        conversation_id: @conversation).destroy_all
    end

    @posts = @conversation.posts.paginate(:page => params[:page], :per_page => 20).order_by_created_at

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    # populate the form with a single reply
    # We use this instead of using @post.new so that the form can be reused
    # for editing as well (we use @conversation.first_post in the form)
    @post = @conversation.posts.build()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @post = @conversation.first_post
  end

  # POST /conversations
  # POST /conversations.json
  def create
    # build will cause this post to get saved when conversation is saved
    @post = @conversation.posts.build(params[:post])
    @conversation.user = @current_user
    @post.user = @current_user

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to [@board, @conversation], notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :created, location: @conversation }
      else
        # Saving failed. To give a descriptive error, if there's a post error we move it
        # to the conversation. This is not ideal, but rails does not facilitate creating
        # models in the manner we're doing
        # TODO: Make this DRY
        if @conversation.errors[:posts]
          @conversation.errors.delete(:posts)
          @post.errors.each do |key, value|
            @conversation.errors[key] = value
          end
        end

        format.html { render action: "new" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /conversations/1
  # PUT /conversations/1.json
  def update
    @post = @conversation.first_post
    @post.assign_attributes(params[:post])
    @conversation.assign_attributes(params[:conversation])

    respond_to do |format|
      if @conversation.save_self_and_post(@post)
        format.html { redirect_to [@board, @conversation], notice: 'Conversation was successfully updated.' }
        format.json { head :no_content }
      else
        # Saving failed. To give a descriptive error, if there's a post error we move it
        # to the conversation. This is not ideal, but rails does not facilitate creating
        # models in the manner we're doing
        # TODO: Make this DRY
        if @conversation.errors[:posts]
          @post.errors.each do |key, value|
            @conversation.errors[key] = value
          end
        end

        format.html { render action: "edit" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to boards_path }
      format.json { head :no_content }
    end
  end

end
