class RemoveCustomerFromTableOrder < ActiveRecord::Migration[7.0]
  def change
    remove_reference :table_orders, :table_customer, null: false, foreign_key: true
  end
end
