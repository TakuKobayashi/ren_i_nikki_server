# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  token           :string(255)      not null
#  using_device_id :integer          not null
#  last_login_at   :datetime         not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_token            (token) UNIQUE
#  index_users_on_using_device_id  (using_device_id)
#

class User < ActiveRecord::Base
end
