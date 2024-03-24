class CreateReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :readings do |t|
      t.datetime :measured_at
      t.decimal :numeric_reading, precision: 5, scale: 2
      t.references :vital, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
