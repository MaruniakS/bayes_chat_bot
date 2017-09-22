class CreateTrainingData < ActiveRecord::Migration[5.0]
  def change
    create_table :training_data do |t|
      t.string :sentence
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :training_data, :sentence, unique: true
  end
end
