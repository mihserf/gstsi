class CreateTrainings < ActiveRecord::Migration
  def self.up
    create_table :trainings do |t|
      t.string :ident_name
      t.integer :num
      t.string :title
      t.text :short_text
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :trainings
  end
end
