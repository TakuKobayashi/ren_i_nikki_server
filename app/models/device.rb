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
end
