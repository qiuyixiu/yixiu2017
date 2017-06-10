class AddStockTagToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :stock_tag, :boolean, default: false
  end
end
