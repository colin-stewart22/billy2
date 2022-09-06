class RemoveServerFromTable < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tables, :server, null: false, foreign_key: true
  end
end
