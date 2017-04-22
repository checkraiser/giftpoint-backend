class CreateCampaignCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_customers do |t|
      t.references :campaign, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
