class AddDefaultValueToTable < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tables, :is_active, default: false
  end
end
