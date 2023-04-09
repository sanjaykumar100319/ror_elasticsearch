
require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do
  desc "Reindex all models that include the Elasticsearch::Model module"
  task reindex: :environment do
    Elasticsearch::Model.client.indices.delete index: '_all'
    ActiveRecord::Base.descendants.select { |d| d.include?(Elasticsearch::Model) }.each do |model|
      model.__elasticsearch__.create_index!
      model.__elasticsearch__.import
    end
    puts "Done reindexing"
  end
end