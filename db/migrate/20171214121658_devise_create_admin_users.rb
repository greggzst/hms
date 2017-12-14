class DeviseCreateAdminUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_users do |t|
      ## Database authenticatable
      t.string :username,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :admin_users, :username,                unique: true
  end
end
