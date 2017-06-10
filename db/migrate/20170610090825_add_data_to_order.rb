class AddDataToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :phone_numbers, :string
  end
end
