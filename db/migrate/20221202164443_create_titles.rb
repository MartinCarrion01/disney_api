class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.string :name
      t.integer :score
      t.belongs_to :genre
      t.integer :title_type
      
      t.timestamps
    end
  end
end
