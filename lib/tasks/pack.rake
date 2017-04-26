namespace :pack do
  desc 'previous authentications set os type'
  task set_default: :environment do
    Pack.update_all(is_visible: true)
    Plan.update_all(is_visible: true)
  end
end
