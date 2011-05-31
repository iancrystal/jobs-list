require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  test "index without user" do
    get :index
    assert_redirected_to :action => "login"
    assert_equal "Please log in" , flash[:notice]
  end

  test "index with user" do
    get :index, {}, { :user_id => users(:ian).id }
    assert_response :success
    assert_template "index"
  end

  test "login" do
    ian = users(:ian)
    post :login, :name => ian.name, :password => 'secret'
    assert_redirected_to :action => "index"
    assert_equal ian.id, session[:user_id]
  end

  test "bad password" do
    ian = users(:ian)
    post :login, :name => ian.name, :password => 'wrong'
    assert_template "login"
  end
  
  
end
