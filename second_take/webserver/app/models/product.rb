class Product < ApplicationRecord
  belongs_to :category
  has_many :product_options
  has_many :related_images
  has_and_belongs_to_many :ingredients

  has_and_belongs_to_many :related, class_name: "Product",
    join_table: 'related_products',
    association_foreign_key: 'related_id'

  translates :title, :body, :tips, :benefits

  def price
    return ProductOption.where(product_id: self.id).first().price
  end

  def weight
    return ProductOption.where(product_id: self.id).first().weight
  end

  def options()
    return ProductOption.where(product_id: self.id)
  end

  def related_images()
    return RelatedImage.where(product_id: self.id)
  end

  def self.json(p)
    return {
      price: p.price(),
      thumbnail: p.thumbnail,
      weight: p.weight,
      slug: p.slug,
      title: p.title,
      body: p.body,
      category: p.category.title,
      options: p.options,
      ingredients: p.ingredients,
      images: p.related_images(),
      related: p.related,
    }
  end

  def self.collection_to_json(products)
    return products.map{|p|
      {
        price: p.price(),
        thumbnail: p.thumbnail,
        weight: p.weight,
        slug: p.slug,
        title: p.title,
        body: p.body,
        category: p.category.title,
        options: p.options,
        # ingredients: p.ingredients,
        # images: p.related_images(),
        # related: p.related,
      }
    }
  end
end
