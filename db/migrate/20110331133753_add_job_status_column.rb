class AddJobStatusColumn < ActiveRecord::Migration
  def self.up
    add_column :jobs, :status, :integer
  end

  def self.down
    remove_column :jobs, :status
  end
end
