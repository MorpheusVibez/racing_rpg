class Driver < ApplicationRecord
    belongs_to :team
    has_many :cars, through: :teams
end
