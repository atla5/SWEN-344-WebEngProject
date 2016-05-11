class CreateSession < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :user
    end
  end
end
