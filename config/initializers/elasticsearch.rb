# frozen_string_literal: true

Elasticsearch::Model.client = Elasticsearch::Client.new(
  hosts: [
    { host: 'localhost', port: 9200 }
  ]
)
