require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, :category => {:name => "programming", :parent_id => 3}
    end
    
    assert Category.find_by_name("programming")

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, :id => categories(:finance).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories(:finance).to_param
    assert_response :success
  end

  test "should update category" do
    put :update, :id => categories(:finance).id, :category => {:name => "fin"}
    assert_equal Category.find(categories(:finance).id).name, "fin"
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, :id => categories(:technology).id
    end

    assert_redirected_to categories_path
  end
end
