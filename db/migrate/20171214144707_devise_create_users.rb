class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.boolean :has_account, default: false
      t.string :firstname
      t.string :lastname
      t.string :valid_document_number
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
