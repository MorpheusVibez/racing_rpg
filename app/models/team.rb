class Team < ApplicationRecord
    has_many :drivers
    has_many :cars
    belongs_to :user

    validates :name, presence: :true
    validates :name, uniqueness: :true
end
