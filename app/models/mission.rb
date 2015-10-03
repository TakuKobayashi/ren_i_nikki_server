# == Schema Information
#
# Table name: missions
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  mst_tv_program_id :integer
#  mst_misson_id     :integer          not null
#  grouping_token    :string(255)      not null
#
# Indexes
#
#  index_missions_on_grouping_token             (grouping_token)
#  index_missions_on_mst_tv_program_id          (mst_tv_program_id)
#  index_missions_on_user_id_and_mst_misson_id  (user_id,mst_misson_id)
#

class Mission < ActiveRecord::Base
end
