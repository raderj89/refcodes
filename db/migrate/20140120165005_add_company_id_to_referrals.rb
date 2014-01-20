class AddCompanyIdToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :company_id, :integer
    add_index :referrals, :company_id
  end
end
