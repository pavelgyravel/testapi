class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.integer :rate, null: false, default: 1
      t.timestamps
    end
  end
end
