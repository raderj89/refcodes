class PagesController < ApplicationController
  def about
    @new_referral = Referral.new
    @new_referral.build_company
  end
end