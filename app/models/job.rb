class Job < ActiveRecord::Base

  has_one :category
  acts_as_textiled :description

  validates_presence_of :category_id, :company, :city, :state, :title, :contact_info
  
  def self.state_array
    %w{ AK AL AR AK CA CO CT DE FL GA HI ID IL IN IA KS KN LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VT VA WA WI WV WY Other }
  end

  def full_website_url
    if self.website !~ /http/i
      "http://" + self.website 
    else
      self.website
    end
  end
end
