require 'test_helper'

class PaymentControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should accept promo code" do
    post :index, {:job_id => jobs(:accountant).id, :promo_code => "FREE30"}
    assert_redirected_to :controller => "jobs", :action => "index"
  end

end
