class AddPublishedToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :published, :boolean
  end
end
