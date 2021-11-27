FactoryBot.define do
  factory :payment_intent do
    user { nil }
    amount { 1 }
    recipient_account_holder_id { "MyString" }
    recipient_account_number { 1 }
    recipient_account_type { "MyString" }
    recipient_account_institution_id { "MyString" }
  end
end
