class Elevation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :part_number, type: String
  field :sku, type: String
  field :u_size, type: Integer
  embeds_many :rack_components
  embedded_in :rack_config
end
