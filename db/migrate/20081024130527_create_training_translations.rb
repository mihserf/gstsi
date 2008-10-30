class CreateTrainingTranslations < ActiveRecord::Migration
  def self.up
    create_table :training_translations do |t|
      t.integer :localedb_id
      t.integer :training_id

      t.string :title
      t.text :short_text
      t.text :body
      
      t.timestamps
    end
  end

  def self.down
    drop_table :training_translations
  end
end
