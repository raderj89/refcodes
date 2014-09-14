class ReferralsController < ApplicationController
  respond_to :html, :js
  require 'will_paginate/array'

  before_action :set_referral, only: [:edit, :update, :destroy]
  before_action(only: [:index, :create]) { |c| c.send(:apply_scope, params) }
  before_action :authenticate_admin!, only: [:edit, :update, :destroy]

  def index
    @referral = Referral.new
    @referral.build_company 

    respond_with(@referrals)
  end

  def create
    @referral = Referral.new(referral_params)

    if @referral.save
      flash.now[:success] = "Referral submitted!"
    end

    @new_referral = Referral.new
    @new_referral.build_company

    respond_with(@referral) do |f|
      f.html { render :index }
      f.js
    end
  end

  def edit
  end

  def update
    if @referral.update(referral_params)
      redirect_to root_path
    end
  end

  def destroy
    @referral.destroy
    flash.now[:warning] = "Referral obliterated."
    
    respond_with(@referral)
  end

  private

    def set_referral
      @referral = Referral.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Could not find that referral."
      redirect_to root_path
    end

    def referral_params
      params.require(:referral).permit(:details, :link, :expiration, :code, :limit, company_attributes: [:name])
    end

    def apply_scope(params)
      if params[:latest]
        @referrals = Referral.latest.paginate(page: params[:page])
      elsif params[:all_time]
        @referrals = Referral.all_time.paginate(page: params[:page])
      elsif params[:query]
        @referrals = Referral.text_search(params[:query]).paginate(page: params[:page])
      else
        @referrals = Referral.trending.paginate(page: params[:page])
      end
    end
end