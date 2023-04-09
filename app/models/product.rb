class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "products-#{Rails.env}"

  mapping do
    indexes :name, type: :text
    indexes :description, type: :text
  end
end
Product.import