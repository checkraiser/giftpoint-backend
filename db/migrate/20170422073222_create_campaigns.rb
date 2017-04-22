class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :name, null: false
      t.text :content
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
