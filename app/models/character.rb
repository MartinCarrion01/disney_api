class Character < ApplicationRecord
    include Attachable

    validates :name, presence: true
    validates :age, numericality: {greater_than_or_equal_to: 0}
    validates :weight, numericality: {greater_than_or_equal_to: 0}
    validates :description, length: {maximum: 500}

    has_many :title_characters
    has_many :titles, through: :title_characters

    scope :filter_by_name, ->(name) {where("name like ?", "#{name}%")}
    scope :filter_by_age, ->(age) {where(age: age)}
    scope :filter_by_title, ->(title_id) {joins(:title_characters).where("title_id = ?", title_id)}

    def self.index(name=nil, age=nil, title_id=nil)
        characters = Character.where(nil)
        characters = characters.filter_by_name(name) if name.present?
        characters = characters.filter_by_age(age) if age.present?
        characters = characters.filter_by_title(title_id) if title_id.present?
        characters = characters.map {|character| {id: character.id, name: character.name, image: character.get_image_url}}
        characters
    end

    def get_detail
        detail = self.as_json(
            only: %i[name age weight description],
            include: {titles: {only: :name}}
        )
        detail
    end
end
