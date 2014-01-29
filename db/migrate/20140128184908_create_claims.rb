class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.references :referral, index: true

      t.timestamps
    end
  end
end
