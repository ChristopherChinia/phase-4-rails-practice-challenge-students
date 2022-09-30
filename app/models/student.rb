class Student < ApplicationRecord
    belongs_to :Instructor

    validates :name, presence: true, uniqueness: true
    validates :major, presence: true
    validates :age, numericality: { greater_than_or_equal_to: 18 }
end
