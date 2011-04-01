class JobPostMailer < ActionMailer::Base
  

  def confirm_post(sent_at = Time.now)
    subject    'JobPostMailer#confirm'
    recipients 'ian_crystal@yahoo.com'
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi post,'
  end

  def confirm_payment(sent_at = Time.now)
    subject    'JobPostMailer#sent'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
