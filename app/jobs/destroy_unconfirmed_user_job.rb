class DestroyUnconfirmedUserJob < ApplicationJob
  queue_as :default

  def perform
    User.where(confirmed_at: nil).where('created_at < ?', Time.zone.now - 1.day).each do |user|
      user.payment_intents.destroy_all
    end
    User.where(confirmed_at: nil).where('created_at < ?', Time.zone.now - 1.day).destroy_all
  end
end
