class Category < ActiveRecord::Base
  acts_as_tree :order => "name"
  belongs_to :job

  def descendants
    children.map { |f| !f.children.empty? ? f.descendants + [f]: f }.flatten
  end
end
