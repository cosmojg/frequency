require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase
  setup do
    @conversation = conversations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conversations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conversation" do
    assert_difference('Conversation.count') do
      post :create, conversation: { board_id: @conversation.board_id, id: @conversation.id, title: @conversation.title, user_id: @conversation.user_id }
    end

    assert_redirected_to conversation_path(assigns(:conversation))
  end

  test "should show conversation" do
    get :show, id: @conversation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conversation
    assert_response :success
  end

  test "should update conversation" do
    put :update, id: @conversation, conversation: { board_id: @conversation.board_id, id: @conversation.id, title: @conversation.title, user_id: @conversation.user_id }
    assert_redirected_to conversation_path(assigns(:conversation))
  end

  test "should destroy conversation" do
    assert_difference('Conversation.count', -1) do
      delete :destroy, id: @conversation
    end

    assert_redirected_to conversations_path
  end
end
