class ApiController < ApplicationController
  # before_action :authenticate_user

  def translation
    render json: {hello: "world"}
  end

  def categories
    @categories = Category.all()
    render json: @categories
  end

  def category
    slug = params[:category_id]
    puts slug
    render json: Category.where(slug: slug)
  end

  def category_products
    slug = params[:category_id]
    puts slug
    @category = Category.where(slug: slug).first()
    puts @category.inspect

    @products = Product.where(category_id: @category.id)
    render json: Product::collection_to_json(@products)
  end

  def products
    @products = Product.all()
    render json: Product::collection_to_json(@products)
  end

  def product
    slug = params[:product_id]
    @product = Product.where(slug: slug).first()
    render json: Product.json(@product)
  end

end
