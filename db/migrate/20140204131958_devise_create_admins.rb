class DeviseCreateAdmins < ActiveRecord::Migration
  def change
    create_table(:admins) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :admins, :email,                :unique => true
    # add_index :admins, :confirmation_token,   :unique => true
    # add_index :admins, :unlock_token,         :unique => true
  end
end
