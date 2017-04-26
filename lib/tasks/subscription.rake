namespace :subscription do
  desc 'previous active subscription mark as inactive after ends_at'
  task inactive_subscriptions: :environment do
    Subscription.active.where('ends_at < ?', Date.current)
      .update_all(is_active: false)
  end
end
