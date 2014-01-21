class ReferralsController < ApplicationController
  def index
    @company = Company.new
    @referral = Referral.new
    @referrals = Referral.all
  end

  def create
    @company = Company.where(name: referral_params[:company]).first_or_create
    @referral = @company.referrals.build(company_id: @company.id, details: referral_params[:details], link: referral_params[:link],
                                         expiration: referral_params[:expiration], code: referral_params[:code], limit: referral_params[:limit])
    if @referral.save
      flash[:success] = "Referral submitted!"
      redirect_to root_url
    else
      flash[:danger] = "Problem submitting referral. Please try again. #{@referral.errors.full_messages.join(" ")}"
      redirect_to root_path
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
      params.require(:referral).permit(:company, :details, :link, :expiration, :code, :limit)
    end
end
