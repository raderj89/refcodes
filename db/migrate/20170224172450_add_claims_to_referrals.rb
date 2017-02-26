class AddClaimsToReferrals < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :claim_count, :integer, null: false, default: 0
  end
end
