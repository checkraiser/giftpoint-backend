class AddUserToCampaignCustomer < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaign_customers, :user, foreign_key: true
  end
end
