class User < ApplicationRecord
  ACCOUNT_TYPES = {
    checking_account: 'checking_account',
    sight_account: 'sight_account'
  }
  BANKS = {
    cl_banco_de_chile: 'cl_banco_de_chile',
    cl_banco_santander: 'cl_banco_santander',
    cl_banco_itau: 'cl_banco_itau',
    cl_banco_bice: 'cl_banco_bice',
    cl_banco_scotiabank: 'cl_banco_scotiabank',
    cl_banco_bci: 'cl_banco_bci',
    cl_banco_estado: 'cl_banco_estado',
    cl_banco_security: 'cl_banco_security',
    cl_banco_ripley: 'cl_banco_ripley',
    cl_banco_falabella: 'cl_banco_falabella',
    cl_tenpo: 'cl_tenpo'
  }
  include Hashid::Rails
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :confirmable

  has_many :payment_intents, dependent: :nullify
  validates :rut, uniqueness: { scope: [:bank, :email] }
  validates :alias, uniqueness: true

  validates :name, :rut, :alias, :bank, :account_number, :account_type, presence: true
  validates :alias, format: { without: /\s/, message: 'must contain no spaces' }

  enum account_type: ACCOUNT_TYPES
  enum bank: BANKS

  private

  def after_confirmation
    UserMailer.welcome_email(self).deliver
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           not null
#  rut                    :string           not null
#  bank                   :string           not null
#  account_number         :bigint(8)        not null
#  account_type           :string           not null
#  alias                  :string           not null
#
# Indexes
#
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
