class ReferralsController < ApplicationController
  require 'will_paginate/array'

  before_action :build_referral, only: [:index, :show, :edit]
  before_action :load_referral, only: [:show, :edit, :update, :destroy]
  before_action :check_for_robots, only: [:create]
  before_action(only: [:index, :create]) { |c| c.send(:apply_scope, params) }
  before_action :authenticate_admin!, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @new_referral = Referral.new(referral_params)

    if @new_referral.save
      flash[:success] = "Referral submitted!"
      redirect_to @new_referral
    else
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    if @referral.update(referral_params)
      redirect_to @referral
    end
  end

  def destroy
    @referral.destroy
    flash.now[:warning] = "Referral obliterated."

    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  private

    def load_referral
      @referral = Referral.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Could not find that referral."
      redirect_to root_path
    end

    def check_for_robots
      if !params[:robot].empty?
        raise "Robot attack!"
      end
    end

    def referral_params
      params.require(:referral).permit(
        :details, :link, :expiration, :code, :limit, company_attributes: [:name]
      )
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
