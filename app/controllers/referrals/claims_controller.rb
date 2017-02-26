class Referrals::ClaimsController < ApplicationController
  before_action :load_referral

  def create
    if @referral.increment_claim_count
      flash.now[:success] = "Claimed referral!"
    else
      flash.now[:danger] = "Couldn't claim referral."
    end

    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  private

  def referral_params
    params.require(:referral_id)
  end

  def load_referral
    @referral = Referral.find(referral_params)
  end
end
