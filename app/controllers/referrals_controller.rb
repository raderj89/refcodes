class ReferralsController < ApplicationController
  require 'will_paginate/array'
  respond_to :html, :js

  before_filter :authenticate_admin!, only: [:edit, :update, :destroy]

  def index
    @company = Company.new
    @referral = Referral.new
    @referrals = Referral.text_search(params[:query]).joins(:company).includes(:claims)
                 .paginate(page: params[:page], per_page: 3)
    @referrals = Referral.find_by_sql("SELECT referrals.* FROM referrals ORDER BY rank DESC").paginate(page: params[:page], per_page: 10) if params[:most_popular]

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @company = Company.where(name: company_params[:name]).first_or_create
    @referral = @company.referrals.build(referral_params)
    @new_referral = Referral.new
    @new_company = Company.new
    @referrals = Referral.text_search(params[:query]).joins(:company).includes(:claims)
                 .paginate(page: params[:page], per_page: 3)
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