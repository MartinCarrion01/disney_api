class Character < ApplicationRecord
    include Attachable

    validates :name, presence: true
    validates :age, numericality: {greater_than_or_equal_to: 0}
    validates :weight, numericality: {greater_than_or_equal_to: 0}
    validates :description, length: {maximum: 500}

    has_many :title_characters
    has_many :titles, through: :title_characters
end
