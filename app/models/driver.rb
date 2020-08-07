class Driver < ApplicationRecord
    belongs_to :team
    validates :name, presence: :true
    validates :name, uniqueness: :true
end
