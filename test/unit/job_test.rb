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
    assert_equal jobs(:payroll_supervisor).description, "<h1>Overview</h1>
<p>Supervise the <strong>payroll</strong> department</p>
<h2><ins>detailed responsibilities</ins></h2>
<ol>
\t<li>printing paychecks</li>
\t<li>giving paychecks</li>
</ol>
<h2>benefits</h2>
<ul>
\t<li>good pay</li>
\t<li>dental</li>
\t<li>medical</li>
</ul>"
  end

end
