class RackConfig
  require 'csv'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :customer, type: String
  field :sku, type: String
  embeds_one :elevation
  accepts_nested_attributes_for :elevation

  def self.import(file, rack_config)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      # Determine and set the document type.
      doc_type = row_hash["doc_type"].downcase

      case doc_type
      when "elevation"
        update_elevation(row_hash, rack_config)
      end
    end
  end

  def self.update_elevation(row_hash, rack_config)
    # Grab elevation data and search for existing Elevation.
    elevation_hash = row_hash.slice(*Elevation.fields.keys.drop(3))
    elevation = rack_config.elevation
    rack = false
    rack = row_hash["rack"].downcase == "true" unless row_hash["rack"].nil?

    # Create new Elevation or update existing docuement.
    new_elevation_with_rack = elevation.nil? && rack
    new_elevation_without_rack = elevation.nil? && !rack
    update_elevation = !elevation.nil? && rack

    if new_elevation_with_rack
      rack_config.create_elevation(elevation_hash)
    elsif new_elevation_without_rack
      rack_config.create_elevation()
      update_rack_component(row_hash, rack_config)
    elsif update_elevation
      elevation.update_attributes!(elevation_hash)
    else
      update_rack_component(row_hash, rack_config)
    end
  end

  def self.update_rack_component(row_hash, rack_config)
    # Grab rack component data and search for existing RackComponent.
    rack_component_hash = row_hash.slice(*RackComponent.fields.keys.drop(3))
    u_location = rack_component_hash["u_location"].to_i
    orientation = rack_component_hash["orientation"]
    rack_component = rack_config.elevation.rack_components.where(u_location: u_location, orientation: orientation)

    # Create new RackComponent or update existing document.
    if rack_component.first.nil?
      rack_config.elevation.rack_components.create!(rack_component_hash)
    else
      rack_component.first.update_attributes!(rack_component_hash)
    end
  end
end
