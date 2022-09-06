class CreateTableOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :table_orders do |t|
      t.boolean :is_active
      t.integer :total_price
      t.string :payment_option
      t.string :group_url
      t.references :table_customer, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
