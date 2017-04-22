class AddPriceAndUnitToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :price, :float, null: false, default: 0
    add_column :products, :unit, :string, null: false
  end
end
