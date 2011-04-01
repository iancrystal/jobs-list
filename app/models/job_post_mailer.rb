class JobPostMailer < ActionMailer::Base
  

  def confirm_post(job = Job.find(22), url = 'http://jobbslist.com')
    subject    'Job Posting Confirmation from jobbslist.com'
    recipients job.customer_email
    from       'support@jobbslist.com'
    sent_on    Time.now
    
    body       :job => job, :url => url
  end

  def confirm_payment(job = Job.find(22), amount = "49.00", card_number = "xxxx-xxxx", full_name = "Joe Smith")
    subject    'Payment Confirmation from jobbslist.com'
    recipients job.customer_email
    from       'support@jobbslist.com'
    sent_on    Time.now
    
    body       :job => job, :amount => amount, :card_number => card_number, :full_name => full_name
  end

end
