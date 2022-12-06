class User < ApplicationRecord
    include Attachable

    has_secure_password
    
    validates :username, presence: true, uniqueness: true
    validates :password, length: {in: 8..20}, if: -> { new_record? || !password.nil? }
end
