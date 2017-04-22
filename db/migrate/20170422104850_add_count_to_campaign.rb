class AddCountToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :count, :integer, null: false, default: 0
  end
end
