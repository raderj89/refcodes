class FillInClaims < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        Referral.all.each do |referral|
          claims_count = referral.claims.count

          referral.update_attribute(:claim_count, claims_count)
        end
      end

      dir.down do
        Referral.update_all(claim_count: 0)
      end
    end
  end
end
