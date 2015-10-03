# == Schema Information
#
# Table name: mission_locations
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  mission_id :integer          not null
#  lat        :float(24)        default(0.0), not null
#  lon        :float(24)        default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_mission_locations_on_lat_and_lon  (lat,lon)
#  index_mission_locations_on_mission_id   (mission_id)
#  index_mission_locations_on_user_id      (user_id)
#

require 'test_helper'

class MissionLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
