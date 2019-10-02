class RenameTypeOnSubscription < ActiveRecord::Migration[6.0]
  def change
    rename_column :subscriptions, :type, :plan
  end
end
