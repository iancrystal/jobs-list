require 'test_helper'
require 'fake_gateway.rb'

class PaymentControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should email payment confirmation" do
    emails = ActionMailer::Base.deliveries
    emails.clear

    post :index, {:job_id => jobs(:accountant).id, }

    assert_equal(1, emails.size)
    email = emails.first
    assert_equal("Payment Confirmation from jobbslist.com" , email.subject)
    assert_equal("ian@sega.com" , email.to[0])
    assert_match(/have been successfully charged/, email.body)
    assert_match(/1234-56789/, email.body)

    assert_redirected_to :controller => "jobs", :action => "index"
  end

  test "should accept promo code" do
    post :index, {:job_id => jobs(:accountant).id, :promo_code => "FREE30"}
    assert_redirected_to :controller => "jobs", :action => "index"
  end

end
