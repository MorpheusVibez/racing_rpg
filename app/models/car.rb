class Car < ApplicationRecord
   has_many :teams
   has_many :drivers, through: :teams
end
