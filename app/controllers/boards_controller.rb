class BoardsController < ApplicationController
  include UpdatesUnread

  load_and_authorize_resource

  def mark_all_as_read
    @current_user.unread_states.delete_all
    flash[:notice] = "All conversations have been marked as read."
    redirect_to boards_path
  end

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.order("created_at asc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @conversations = @board.conversations.order_by_last_reply.includes(:user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/1/edit
  def edit
    # Nothing here for now
  end

  # POST /boards
  # POST /boards.json
  def create
    respond_to do |format|
      if @board.save
        format.html { redirect_to boards_path, notice: 'Board was successfully created.' }
        format.json { render json: @board, status: :created, location: @board }
      else
        format.html { render action: "new" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to boards_path, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_path }
      format.json { head :no_content }
    end
  end
end
