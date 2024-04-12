class AddTitleAndDescriptionToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :title, :string
    add_column :forms, :description, :string
  end
end
