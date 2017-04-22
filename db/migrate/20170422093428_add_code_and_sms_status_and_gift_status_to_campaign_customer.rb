class AddCodeAndSmsStatusAndGiftStatusToCampaignCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :campaign_customers, :code, :string, index: true
    add_column :campaign_customers, :sms_status, :boolean, null: false, default: false, index: true
    add_column :campaign_customers, :gift_status, :boolean, null: false, default: false, index: true
  end
end
