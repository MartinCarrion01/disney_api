class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.string :name
      t.integer :score
      t.belongs_to :genre
      
      t.timestamps
    end
  end
end
