require 'test_helper'

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "posting a job ad" do
    get "/"
    assert_response :success
    assert_template "index"

    get "/jobs/new"
    assert_response :success
    assert_template "new"

    post "/jobs", :job => {
      :category_id => "4",
      :title => "Accountant",
      :company => "Sega Corporation",
      :city => "San Mateo",
      :state => "CA",
      :website => "http://sega.com",
      :description => "perform accounting duties",
      :contact_info => "email your resume to ian@sega.com",
      :status => "1",
      :customer_email => "ian@sega.com"
    }
    assert_redirected_to :controller => "payment", :action => "index"

  end
end
