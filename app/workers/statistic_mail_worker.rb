# StatisticMailWorker
class StatisticMailWorker
  # include Sidekiq::Worker
  def start
    customers = Customer.where(
      'created_at > ?', DateTime.current - 1.day)
    subscriptions = Subscription.where(
      'created_at > ?', DateTime.current - 1.day)
    CustomerRegister.notify(customers, subscriptions).deliver_now
  end
end
