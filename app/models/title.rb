class Title < ApplicationRecord
    include Attachable

    validates :name, presence: true
    validates :score, numericality: {in: 0..5}
    
    belongs_to :genre
    has_many :title_characters
    has_many :characters, through: :title_characters

    scope :filter_by_name, ->(name) {where("name like ?", "#{name}%")}
    scope :filter_by_genre, ->(genre_id) {where(genre_id: genre_id)}

    def self.index(name=nil, genre_id=nil, order=nil)
        titles = Title.select(:id, :name, :created_at)
        titles = titles.filter_by_name(name) if name.present?
        titles = titles.filter_by_genre(genre_id) if genre_id.present?
        titles = titles.order("created_at #{order}") if order.present?
        titles = titles.map {|title| {id: title.id, name: title.name, created_at: title.created_at ,image: title.get_image_url}}
        titles
    end

    def get_detail
        detail = self.as_json(
            only: %i[name score created_at],
            methods: %i[get_image_url],
            include: {characters: {only: :name}}
        )
        detail
    end
end
