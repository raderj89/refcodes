class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def build_referral
    @new_referral = Referral.new
    @new_referral.build_company
  end
end
