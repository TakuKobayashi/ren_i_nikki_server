class Api::UsersController < Api::BaseController
  skip_before_filter :authentication

  def login
    logger.info request.env['HTTP_X_REAL_IP']
  	ActiveRecord::Base.transaction do
      google_account = GoogleAccount.find_or_initialize_by(uid: params[:google_id])
      if google_account.new_record?
        user = User.create!(name: params[:name])
        google_account.update!(user_id: user.id)
      end
      device = user.devices.find_or_initialize_by(bluetooth_mac_address: params[:mac_address])
      device.update!(category: params[:category], notification_token: params[:notification_token])
      user.update!(using_device_id: device.id) if device.smartphone?
    end
    head(:ok)
  end
end
