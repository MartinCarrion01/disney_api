class Title < ApplicationRecord
    include Attachable

    validates :name, presence: true
    validates :score, numericality: {in: 0..5}
    
    belongs_to :genre
    has_many :title_characters
    has_many :characters, through: :title_characters
end
