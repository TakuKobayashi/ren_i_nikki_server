# coding: utf-8
class Api::BaseController < BaseController
  include Api::ErrorHandling

  skip_before_filter :verify_authenticity_token
  before_filter :authentication

  private
  def authentication
    google_account = GoogleAccount.find_by!(uid: params[:google_id])
    @user = google_account.user
    raise AuthenticationError "authenticate failed" and return false if @user.blank?
  end
end
