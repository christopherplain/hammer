class Elevation
  include Mongoid::Document
  include Mongoid::Timestamps
  field :part_number, type: String
  field :sku, type: String
  field :u_size, type: Integer
  embeds_many :rack_components
  embedded_in :rack_config

  def self.field_keys
    Elevation.fields.keys.drop(3)
  end
end
