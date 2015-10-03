# == Schema Information
#
# Table name: mst_missions
#
#  id      :integer          not null, primary key
#  title   :string(255)
#  message :string(255)
#  lat     :float(24)        default(0.0), not null
#  lon     :float(24)        default(0.0), not null
#

require 'test_helper'

class Mst::MissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
