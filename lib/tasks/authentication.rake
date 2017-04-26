namespace :authentication do
  desc 'previous authentications set os type'
  task update_os: :environment do
    Authentication.where(os: nil).update_all(os: 'android')
  end
end
