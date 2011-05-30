require 'test_helper'

class JobPostMailerTest < ActionMailer::TestCase

  def setup
    @job = jobs(:accountant) 
    @url = "http://jobbslist.com/payment/index/#{@job.id}"
  end

  test "confirm_post" do
    
    response = JobPostMailer.create_confirm_post(@job, @url)

    assert_equal("Job Posting Confirmation from jobbslist.com" , response.subject)
    assert_equal("ian@sega.com" , response.to[0])
    assert_match(/Thank you for your recent job posting/, response.body)
    assert_match(/#{@url}/, response.body)
    
  end

  test "confirm_payment" do
    response = JobPostMailer.create_confirm_payment(@job, "49.00", "xxxx-xxxx", "Joe Smith")

    assert_equal("Payment Confirmation from jobbslist.com" , response.subject)
    assert_equal("ian@sega.com" , response.to[0])
    assert_match(/Thank you for your payment/, response.body)
    assert_match(/#{@job.title}/, response.body)
    
  end

end
