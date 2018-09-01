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

  def self.update(row_hash, rack_config)
    # Grab elevation data and search for existing Elevation.
    elevation_hash = row_hash.slice(*Elevation.field_keys)
    elevation = rack_config.elevation
    rack = false
    rack = row_hash["rack"].downcase == "true" unless row_hash["rack"].nil?

    # Create new Elevation or update existing docuement.
    return rack_config.create_elevation(elevation_hash) if elevation.nil? && rack
    return rack_config.create_elevation() if elevation.nil? && !rack
    elevation.update_attributes!(elevation_hash) if rack
    elevation
  end
end
