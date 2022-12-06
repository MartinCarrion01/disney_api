class Character < ApplicationRecord
    include Attachable

    validates :name, presence: true
    validates :age, numericality: {greater_than_or_equal_to: 0}
    validates :weight, numericality: {greater_than_or_equal_to: 0}
    validates :description, length: {maximum: 500}

    has_many :title_characters
    has_many :titles, through: :title_characters

    scope :filter_by_name, ->(name) {where(name: name)}
    scope :filter_by_age, ->(age) {where(age: age)}
    #scope :filter_by_age, ->(movie_id) {where(age: age)}

    def self.list
        characters = Character.select(:name, :id)
        characters = characters.map {|character| {id: character.id, name: character.name, image: character.get_image_url}}
        characters
    end

    def self.index(name=nil, age=nil)
        characters = Character.where(nil)
        characters = characters(name)
    end

    def self.search_by(name, age, title_id)
        #results = 
    end

    def get_detail
        detail = self.as_json(
            only: %i[name age weight description],
            include: {titles: {only: :name}}
        )
        detail
    end
end
