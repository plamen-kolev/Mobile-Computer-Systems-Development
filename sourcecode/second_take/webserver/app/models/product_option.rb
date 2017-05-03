class ProductOption < ApplicationRecord
  belongs_to :product
  translates :title
end
