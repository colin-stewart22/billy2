class ChangeColumnDefault < ActiveRecord::Migration[7.0]
  def change
    t.boolean :is_served, default: false
  end
end
