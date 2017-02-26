class PagesController < ApplicationController
  before_action :build_referral, only: [:about]

  def about
  end
end
