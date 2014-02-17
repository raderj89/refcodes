class ClaimsController < ApplicationController
  before_action :setup

  respond_to :html, :js

  def create
    @claim = @referral.claims.new

    if @claim.save
      flash.now[:success] = "Claimed referral!"
    else
      flash.now[:danger] = "Couldn't claim referral."
    end

    respond_with(@claim) do |f|
      f.html { redirect_to root_path }
    end
  end

  private

  def claim_params
    params.require(:referral_id)
  end

  def setup
    @referral = Referral.find(claim_params)
  end

end