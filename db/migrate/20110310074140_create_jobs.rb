class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :category_id
      t.string :title
      t.string :company
      t.string :city
      t.string :state
      t.string :website
      t.text :description
      t.text :contact_info

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
