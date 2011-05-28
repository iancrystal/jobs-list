require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post :create, :job => {
        :category_id => 5,
        :title => "Payroll Manager",
        :company => "CalPak",
        :city => "Hayward",
        :state => "CA",
        :website => "www.calpak.com",
        :description => "*manage* the payroll department",
        :contact_info => "email your resume to steve@calpak.com",
        :status => 1,
        :customer_email => "steve@calpak.com"
      }
    end

    assert_redirected_to :controller => "payment"
  end

  test "should show job" do
    get :show, :id => jobs(:accountant).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jobs(:accountant).to_param
    assert_response :success
  end

  test "should update job" do
    put :update, :id => jobs(:accountant).to_param, :job => {
        :customer_email => "romina@sega.com"
    }
    assert_equal Job.find_by_title("Accountant").customer_email, "romina@sega.com"
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete :destroy, :id => jobs(:accountant).to_param
    end

    assert_redirected_to jobs_path
  end
end
