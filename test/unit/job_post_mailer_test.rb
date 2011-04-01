require 'test_helper'

class JobPostMailerTest < ActionMailer::TestCase
  test "confirm" do
    @expected.subject = 'JobPostMailer#confirm'
    @expected.body    = read_fixture('confirm')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobPostMailer.create_confirm(@expected.date).encoded
  end

  test "sent" do
    @expected.subject = 'JobPostMailer#sent'
    @expected.body    = read_fixture('sent')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JobPostMailer.create_sent(@expected.date).encoded
  end

end
