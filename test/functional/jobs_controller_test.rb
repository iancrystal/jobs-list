require 'test_helper'

class JobsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should expire" do
    # should not display postings more than 30 days old
    age = 35
    jobs(:old).created_at = Time.now - (age * (24 * 60 * 60))
    jobs(:old).save
    get :index
    assert_select "a", :text => /Cobol Programmer/, :count => 0
    # should display postings less than 30 days old
    age = 25
    jobs(:old).created_at = Time.now - (age * (24 * 60 * 60))
    jobs(:old).save
    get :index
    assert_select "a", :text => /Cobol Programmer/, :minimum => 1
  end

  test "should not show unpaid postings" do
    # test hide unpaid listing
    jobs(:old).status = 0 
    jobs(:old).save
    get :index
    assert_select "a", :text => /Cobol Programmer/, :count => 0
    # test show paid listing
    jobs(:old).status = 1 
    jobs(:old).save
    get :index
    assert_select "a", :text => /Cobol Programmer/, :minimum => 1
  end

  test "should preview redcloth" do
    xhr(:get, :preview, :job => { 
      :city => "test1",
      :company => "test1",
      :title => "test1",
      :website => "http://test1.com",
      :contact_info => "email ian@test1.com",
      :description => jobs(:payroll_supervisor).description,
      :category_id => 7,
      :customer_email => "ian@test1.com",
      :state => "CA" } )
    # test redcloth works
    assert_select "div#job_description h1", "Overview"
    assert_select "div#job_description p strong", "payroll"
    assert_select "div#job_description ol li", "giving paychecks"
    assert_select "div#job_description h2", "benefits"
    assert_select "div#job_description ul li", "good pay"
    assert_response :success
  end

  test "should search" do
    get :index, {:search => "cobol", :category => 3}
    assert_select "a", :text => /Cobol Programmer/, :minimum => 1
    # make sure postings with no cobol string are not included
    assert_select "a", :text => /Accountant/, :count => 0
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job ad and email confirmation" do

    emails = ActionMailer::Base.deliveries
    emails.clear

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

    assert_equal(1, emails.size)
    email = emails.first
    assert_equal("Job Posting Confirmation from jobbslist.com" , email.subject)
    assert_equal("steve@calpak.com" , email.to[0])
    assert_match(/Thank you for your recent job posting/, email.body)
    assert_match(/#{@url}/, email.body)

    assert_redirected_to :controller => "payment"

  end

  test "should show job" do
    get :show, :id => jobs(:accountant).to_param
    assert_response :success
  end

  test "should get edit" do
    session[:user_id] = users(:ian).to_param
    get :edit, :id => jobs(:accountant).to_param
    assert_response :success
  end

  test "should update job" do
    session[:user_id] = users(:ian).to_param
    @input_attributes = {
      :category_id => 4,
      :title => "Tax Accountant",
      :company => "Atari Corporation",
      :city => "Santa Clara",
      :state => "CA",
      :website => "http://nintendo.com",
      :description => "perform tax accounting duties",
      :contact_info => "email your resume to ian@nintendo.com",
      :status => 1,
      :customer_email => "ian@nintendo.com"
    }

    put :update, :id => jobs(:accountant).to_param, :job => {
        :customer_email => "romina@sega.com"
    }
    assert_equal Job.find_by_title("Accountant").customer_email, "romina@sega.com"
    assert_redirected_to job_path(assigns(:job))

    put :update, :id => jobs(:accountant).to_param, :job => @input_attributes
    assert_equal Job.find_by_title("Tax Accountant").customer_email, "ian@nintendo.com"
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    session[:user_id] = users(:ian).to_param
    assert_difference('Job.count', -1) do
      delete :destroy, :id => jobs(:accountant).to_param
    end

    assert_redirected_to jobs_path
  end
end
