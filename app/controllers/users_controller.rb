class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.order("created_at asc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @latest_activity = @user.activity.order("created_at desc").limit(20)
    @posts = @user.posts
    @pictures = @user.pictures.order("created_at desc")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    # nothing yet
  end

  # POST /users
  # POST /users.json
  def create
    # cancan's load resource is skipped here to allow for protected
    # field assignment
    @user = User.new
    @user.email = params[:user][:email]
    @user.username = params[:user][:username]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    # Remove the protected fields so that assign_attributes can succeed
    [:username, :email, :password, :password_confirmation].each do |key|
      params[:user].delete(key)
    end

    @user.assign_attributes(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'Your account was created successfully. Welcome!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user.email = params[:user][:email]
    @user.username = params[:user][:username]
    unless params[:user][:password].empty?
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
    end

    [:username, :email, :password, :password_confirmation].each do |key|
      params[:user].delete(key)
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Your profile changes have been saved.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
