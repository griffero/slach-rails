namespace :users do
  task clean_users: :environment do
    DestroyUnconfirmedUserJob.perform_later
  end
end
