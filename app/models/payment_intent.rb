class PaymentIntent < ApplicationRecord
  belongs_to :user

  validates :amount, :recipient_account_holder_id, :recipient_account_number,
            :recipient_account_type, :recipient_account_institution_id, presence: true
end

# == Schema Information
#
# Table name: payment_intents
#
#  id                               :bigint(8)        not null, primary key
#  user_id                          :bigint(8)        not null
#  amount                           :integer          not null
#  recipient_account_holder_id      :string           not null
#  recipient_account_number         :bigint(8)        not null
#  recipient_account_type           :string           not null
#  recipient_account_institution_id :string           not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  payment_status                   :string
#
# Indexes
#
#  index_payment_intents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
