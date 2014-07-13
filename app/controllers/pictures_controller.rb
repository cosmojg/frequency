class PicturesController < ApplicationController
  load_and_authorize_resource

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.order("created_at desc")

    if params[:sort] == "popularity"
      @pictures = Picture.order("views desc")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @newer_picture = Picture.where("created_at > ?", @picture.created_at).order("created_at asc").first
    @older_picture = Picture.where("created_at < ?", @picture.created_at).order("created_at desc").first

    # Loop back to the first / last picture
    @newer_picture ||= Picture.order("created_at asc").first
    @older_picture ||= Picture.order("created_at desc").first

    # Increment view counter
    if (@current_user != @picture.user) && @current_user_session
      @picture.views += 1
      @picture.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    # Nothing for now
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture.user = current_user

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render json: @picture, status: :created, location: @picture }
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def like
    @picture.liked_by current_user
    redirect_to @picture
  end

  def unlike
    # unliked_by isn't working, so we do this instead
    @picture.unliked_by voter: current_user
    redirect_to @picture
  end
end
