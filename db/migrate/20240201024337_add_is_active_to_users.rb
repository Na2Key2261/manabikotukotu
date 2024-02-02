class AddIsActiveToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :usrs, :is_active, :boolean, default: true
  end
end
