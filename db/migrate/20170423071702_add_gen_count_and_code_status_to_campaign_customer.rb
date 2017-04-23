class AddGenCountAndCodeStatusToCampaignCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :campaign_customers, :code_status, :boolean, null: false, default: false
  end
end
