class BlogsController < ApplicationController
  load_and_authorize_resource

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  def like
    @blog.liked_by current_user
    redirect_to @blog
  end

  def unlike
    @blog.unliked_by voter: current_user
    redirect_to @blog
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    # Nothing here!
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog.user = current_user

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end
end
