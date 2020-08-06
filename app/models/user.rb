class User < ApplicationRecord
    has_secure_password
    has_many :teams
    has_many :drivers, through: :teams
    
    validates :username, presence: :true
    validates :username, uniqueness: :true
    accepts_nested_attributes_for :teams
end
