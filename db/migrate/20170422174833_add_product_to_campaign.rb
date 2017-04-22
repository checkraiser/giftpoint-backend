class AddProductToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaigns, :product, foreign_key: true
  end
end
