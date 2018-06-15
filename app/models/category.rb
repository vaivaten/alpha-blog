class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :name, length: { minimum: 3, maximum: 25 }
end
