class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :email
      t.integer :type

      t.timestamps
    end
  end
end
