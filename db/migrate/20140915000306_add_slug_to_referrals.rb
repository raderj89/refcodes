class AddSlugToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :slug, :string
    add_index :referrals, :slug, unique: true
  end
end
