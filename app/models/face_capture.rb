# == Schema Information
#
# Table name: face_captures
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  expression_category :integer          not null
#  mst_tv_program_id   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_face_captures_on_user_id_and_expression_category  (user_id,expression_category)
#

class FaceCapture < ActiveRecord::Base
  enum expression_category: {
  	neutral: 0,
  	happiness: 1,
  	anger: 2,
  	surprise: 3,
  	sadness: 4
  }
end
