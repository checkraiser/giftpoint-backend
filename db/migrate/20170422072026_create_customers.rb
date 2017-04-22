class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :phone, null: false, index: true, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
