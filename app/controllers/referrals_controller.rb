class ReferralsController < ApplicationController

  respond_to :html, :js

  def index
    @company = Company.new
    @referral = Referral.new
    @referrals = Referral.all
  end

  def create
    @company = Company.where(name: company_params[:name]).first_or_create
    @referral = @company.referrals.build(referral_params)
    @new_referral = Referral.new
    @new_company = Company.new

    if @referral.save
      flash.now[:success] = "Referral submitted!"
    end

    respond_with(@referral) do |f|
      f.html { render :index }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def referral_params
      params.require(:referral).permit(:details, :link, :expiration, :code, :limit)
    end

    def company_params
      params.require(:company).permit(:name)
    end
end

#params.require(:referral).permit(permit(:company, :details, :link, :expiration, :code, :limit)).merge(company_id: @company.id)