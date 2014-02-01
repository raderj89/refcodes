class AddRankToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :rank, :float
  end
end
