class AddComponentsToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :components, :jsonb
  end
end
