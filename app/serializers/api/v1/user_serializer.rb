class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :rut, :bank, :account_number, :account_type, :confirmed

  def confirmed
    object.confirmed?
  end
end
