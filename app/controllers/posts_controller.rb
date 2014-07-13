class PostsController < ApplicationController
  load_and_authorize_resource :board
  load_and_authorize_resource :conversation, through: :board
  load_and_authorize_resource :post, through: :conversation

  respond_to :html, :json

  # GET /posts/new
  # GET /posts/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post.user = @current_user

    respond_to do |format|
      if @post.save
        page_number = @post.page_number
        format.html { redirect_to board_conversation_path(@board, @conversation, page: page_number, anchor: "post-#{@post.id}"), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        page_number = @post.page_number
        format.html { redirect_to board_conversation_path(@board, @conversation, page: page_number, anchor: "post-#{@post.id}"), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to [@board, @conversation], notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def like
    @post.liked_by current_user
    page_number = @post.page_number
    respond_to do |format|
      format.html { redirect_to board_conversation_path(@board, @conversation, page: page_number, anchor: "post-#{@post.id}") }
    end
  end

  def unlike
    @post.unliked_by voter: current_user
    page_number = @post.page_number
    respond_to do |format|
      format.html { redirect_to board_conversation_path(@board, @conversation, page: page_number, anchor: "post-#{@post.id}") }
    end
  end
end
