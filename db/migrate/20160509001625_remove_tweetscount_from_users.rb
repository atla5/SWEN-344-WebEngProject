class RemoveTweetscountFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :tweetscount, :integer
    remove_column :users, :followerscount, :integer
  end
end
