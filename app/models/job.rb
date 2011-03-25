class Job < ActiveRecord::Base
  has_one :category

  def full_website_url
    if self.website !~ /http/i
      "http://" + self.website 
    else
      self.website
    end
  end
end
