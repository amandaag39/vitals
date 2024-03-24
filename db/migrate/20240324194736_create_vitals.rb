class CreateVitals < ActiveRecord::Migration[7.0]
  def change
    create_table :vitals do |t|
      t.string :name
      t.integer :category
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
