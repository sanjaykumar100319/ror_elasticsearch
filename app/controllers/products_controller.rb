class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  # GET    /products
  def index
    @products = Product.search(query: { match_all: {} }).records
    render json: { status: :show, products: @products }
  end

  # POST   /products(.:format)
  def create
    @product = Product.new(product_params)

    if @product.save
      @product.__elasticsearch__.index_document
      render json: { status: :created, product: @product }
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description)
  end
end
