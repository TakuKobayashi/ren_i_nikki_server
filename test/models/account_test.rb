# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  account_type :string(255)      not null
#  uid          :string(255)      not null
#  token        :string(255)
#  token_secret :string(255)
#  expired_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_accounts_on_uid                       (uid)
#  index_accounts_on_user_id_and_account_type  (user_id,account_type) UNIQUE
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
