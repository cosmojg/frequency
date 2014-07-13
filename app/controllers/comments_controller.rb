class CommentsController < ApplicationController
  load_and_authorize_resource :picture
  load_and_authorize_resource :comment, through: :picture

  # GET /comments/new
  # GET /comments/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    # That's all, folks!
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment.user = @current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @picture, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @picture, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @picture, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def like
    @comment.liked_by current_user
    redirect_to @picture
  end

  def unlike
    # unliked_by isn't working, so we do this instead
    @comment.unliked_by voter: current_user
    redirect_to @picture
  end
end
