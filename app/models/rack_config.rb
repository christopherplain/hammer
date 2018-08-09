class RackConfig
  require 'csv'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :sku, type: String
  embeds_one :elevation
  belongs_to :customer
  accepts_nested_attributes_for :elevation

  def self.field_keys
    RackConfig.fields.keys.drop(3)
  end

  def self.import(file, rack_config)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      elevation = update_elevation(row_hash, rack_config)
      rack_component = update_rack_component(row_hash, elevation)
      update_connection(row_hash, rack_component)
    end
  end

  def self.update_elevation(row_hash, rack_config)
    # Grab elevation data and search for existing Elevation.
    elevation_hash = row_hash.slice(*Elevation.field_keys)
    elevation = rack_config.elevation
    rack = false
    rack = row_hash["rack"].downcase == "true" unless row_hash["rack"].nil?

    # Create new Elevation or update existing docuement.
    new_elevation_with_rack = elevation.nil? && rack
    new_elevation_without_rack = elevation.nil? && !rack

    if new_elevation_with_rack
      elevation = rack_config.create_elevation(elevation_hash)
    elsif new_elevation_without_rack
      elevation = rack_config.create_elevation()
    else
      elevation.update_attributes!(elevation_hash)
    end
    return elevation
  end

  def self.update_rack_component(row_hash, elevation)
    # Grab rack component data and search for existing RackComponent.
    rack_component_hash = row_hash.slice(*RackComponent.field_keys)
    u_location = rack_component_hash["u_location"].to_i
    orientation = rack_component_hash["orientation"]
    part_number = row_hash["part_number"]
    rack_component = elevation.rack_components.where(
      u_location: u_location, orientation: orientation).first
    part = Part.where(part_number: part_number).first

    # Create new RackComponent or update existing document.
    if rack_component.nil?
      rack_component = elevation.rack_components.create!(rack_component_hash)
    else
      rack_component.update_attributes!(rack_component_hash)
    end
    rack_component.parts.push(part) if part
    return rack_component
  end

  def self.update_connection(row_hash, rack_component)
    # Grab connection data and search for existing Connection.
    connection_hash = row_hash.slice(*Connection.field_keys)
    local_port = connection_hash["local_port"]
    connection = rack_component.connections.where(local_port: local_port).first

    # Create new Connection or update existing document.
    if connection.nil?
      connection = rack_component.connections.create!(connection_hash)
    else
      connection.update_attributes!(connection_hash)
    end
    return connection
  end
end
