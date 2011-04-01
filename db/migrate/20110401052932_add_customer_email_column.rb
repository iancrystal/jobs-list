class AddCustomerEmailColumn < ActiveRecord::Migration
  def self.up
    add_column :jobs, :customer_email, :string
  end

  def self.down
    remove_column :jobs, :customer_email
  end
end
