class Ingredient < ApplicationRecord
  translates :title, :body
  has_and_belongs_to_many :products
end
