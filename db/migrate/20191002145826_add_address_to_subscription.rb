class AddAddressToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :country, :integer
    add_column :subscriptions, :city, :integer
    add_column :subscriptions, :address, :string
  end
end
