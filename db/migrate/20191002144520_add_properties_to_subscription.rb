class AddPropertiesToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :id_type, :integer
    add_column :subscriptions, :tax_id, :string
    add_column :subscriptions, :account_type, :integer
    add_column :subscriptions, :account_number, :string
  end
end
