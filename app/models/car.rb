class Car < ApplicationRecord
   has_many :teams
   has_many :drivers, through: :teams

   accepts_nested_attributes_for :teams, :drivers
end
