# == Schema Information
#
# Table name: mst_tv_programs
#
#  id          :integer          not null, primary key
#  ProgID      :string(255)      not null
#  TSStart     :datetime         not null
#  TSEnd       :datetime         not null
#  RealTSStart :datetime         not null
#  RealTSEnd   :datetime         not null
#  Date        :datetime         not null
#  Week        :integer          not null
#  ServiceID   :string(255)      not null
#  GenreID     :string(255)      not null
#  Title       :string(255)      not null
#  Complete    :integer          not null
#  NumScene    :integer          not null
#  NumCM       :integer          not null
#  NumProduct  :integer          not null
#  NumShop     :integer          not null
#  TSUpdate    :datetime         not null
#

require 'test_helper'

class Mst::TvProgramTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
