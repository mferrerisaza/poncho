class AddTransactionToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :payment, :json
  end
end
