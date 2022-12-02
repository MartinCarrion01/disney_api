class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.decimal :weight
      t.text :description
      
      t.timestamps
    end
  end
end
