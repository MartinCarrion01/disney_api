class Genre < ApplicationRecord
    include Attachable

    validates :name, presence: true, uniqueness: true
end
