class ReferralsController < ApplicationController
  respond_to :html, :js
  require 'will_paginate/array'

  before_filter :authenticate_admin!, only: [:edit, :update, :destroy]

  def index
    @company = Company.new
    @referral = Referral.new

    if params[:latest]
      @referrals = Referral.latest.paginate(page: params[:page], per_page: 10)
    elsif params[:all_time]
      @referrals = Referral.all_time.paginate(page: params[:page], per_page: 10)
    elsif params[:query]
      @referrals = Referral.text_search(params[:query]).paginate(page: params[:page], per_page: 10)
    else
      @referrals = Referral.paginate(page: params[:page], per_page: 10)
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  def create
    @company = Company.where(name: company_params[:name]).first_or_create
    @referral = @company.referrals.build(referral_params)

    if @referral.save
      flash.now[:success] = "Referral submitted!"
    end

    @new_referral = Referral.new
    @new_company = Company.new
    @referrals = Referral.text_search(params[:query])
                  .paginate(page: params[:page], per_page: 10)

    respond_with(@referral) do |f|
      f.html { render :index }
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @referral = Referral.find(params[:id]).destroy
    flash[:warning] = "Referral obliterated."
    redirect_to root_url
  end

  private

    def referral_params
      params.require(:referral).permit(:details, :link, :expiration, :code, :limit)
    end

    def company_params
      params.require(:company).permit(:name)
    end
end