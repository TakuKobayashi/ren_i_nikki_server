# == Schema Information
#
# Table name: devices
#
#  id                    :integer          not null, primary key
#  user_id               :integer          not null
#  category              :integer          not null
#  notification_token    :string(255)
#  bluetooth_mac_address :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_devices_on_bluetooth_mac_address  (bluetooth_mac_address)
#  index_devices_on_user_id_and_category   (user_id,category)
#

class Device < ActiveRecord::Base
  APIKEY = "AIzaSyB_fKqU1P8EUQuUJOGPQXIWacLgayL1k6s"

  belongs_to :user

  enum category: {
  	smartphone: 0,
  	tv: 1
  }

  def self.send_message(data, user_ids = [])
    gcm = GCM.new(APIKEY)
    scope = Device.where.not(notification_token: nil)
    scope = scope.where(user_id: user_ids) if user_ids.present?
    send_user_ids = []
    response = {}
    scope.find_in_batches do |devices|
      registration_ids = devices.map(&:notification_token)
      response = gcm.send_notification(registration_ids, {data: data})
      send_user_ids += devices.map(&:user_id)
    end
    return {send_user_ids: send_user_ids}.merge(response)
  end
end
