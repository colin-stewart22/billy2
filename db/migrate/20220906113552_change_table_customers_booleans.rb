class ChangeTableCustomersBooleans < ActiveRecord::Migration[7.0]
  def change
    t.boolean :is_captain, default: false
    t.boolean :is_paid, default: false
  end
end
