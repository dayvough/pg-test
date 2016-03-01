class AddToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :integer
    add_column :users, :version, :integer
    add_column :users, :created_at, :datetime
    add_column :users, :updated_at, :datetime
  end
end
