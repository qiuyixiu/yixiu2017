class AddRecommendToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :recommend, :string
  end
end
