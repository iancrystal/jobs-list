require 'test_helper'

class JobTest < ActiveSupport::TestCase

  test "invalid with empty attributes" do
    job = Job.new
    assert !job.valid?

    assert job.errors.invalid?(:customer_email)
    assert job.errors.invalid?(:category_id)
    assert job.errors.invalid?(:company)
    assert job.errors.invalid?(:city)
    assert job.errors.invalid?(:state)
    assert job.errors.invalid?(:title)
    assert job.errors.invalid?(:contact_info)
  end

  test "full website url" do
    assert_equal jobs(:payroll_supervisor).full_website_url, "http://www.calpak.com"
    assert_equal jobs(:accountant).full_website_url, "http://sega.com"
  end

  test "description acts as textiled" do
    assert_equal jobs(:payroll_supervisor).description, "<p><strong>supervise</strong> the payroll department</p>"
  end

end
