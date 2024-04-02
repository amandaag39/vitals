class AddTextReadingToReadings < ActiveRecord::Migration[7.0]
  def change
    add_column :readings, :text_reading, :text
  end
end
