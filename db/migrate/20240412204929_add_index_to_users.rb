class AddIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, 'upper(username)', unique: true
    add_index :users, 'upper(email)', unique: true
  end
end
