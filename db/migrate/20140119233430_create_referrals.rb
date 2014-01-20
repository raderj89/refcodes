class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :details
      t.string :link
      t.string :code
      t.date :expiration
      t.integer :limit

      t.timestamps
    end
  end
end
