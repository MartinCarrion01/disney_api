class CreateTitleCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :title_characters do |t|
      t.belongs_to :title
      t.belongs_to :character
      
      t.timestamps
    end
  end
end
