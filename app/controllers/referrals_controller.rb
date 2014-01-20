class ReferralsController < ApplicationController
  def index
    @referrals = Referral.all
    @referral = Referral.new
  end

  def create
    @referral = Referral.new(referral_params)
    if @referral.save
      flash[:success] = "Referral submitted!"
      redirect_to root_url
    else
      flash[:danger] = "Problem submitting referral. Please try again. #{@referral.errors.full_messages}"
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
      params.require(:referral).permit(:details, :link, :date, :code, :limit)
    end
end
