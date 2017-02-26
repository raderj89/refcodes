class DropClaims < ActiveRecord::Migration[5.0]
  def up
    drop_table :claims
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
