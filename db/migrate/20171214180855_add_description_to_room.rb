class AddDescriptionToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :description, :text
  end
end
