class RackConfig
  require 'csv'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :sku, type: String
  embeds_one :elevation
  embeds_many :interfaces
  belongs_to :customer
  accepts_nested_attributes_for :elevation, :interfaces

  def self.field_keys
    RackConfig.fields.keys.drop(3)
  end

  def self.import(file, rack_config)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      elevation = update_elevation(row_hash, rack_config)
      component = update_rack_component(row_hash, elevation)
      (1..100).each do |n|
        interface = Interface.update(row_hash, rack_config, n)
        break if interface.nil?
        Connection.update(row_hash, interface, component, n)
      end
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
    elsif rack
      elevation.update_attributes!(elevation_hash)
    end
    elevation
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
    if part
      rack_component_hash[:part_id] = part.id
    else
      rack_component_hash[:part_id] = nil
    end

    # Create new RackComponent or update existing document.
    if rack_component.nil?
      rack_component = elevation.rack_components.create!(rack_component_hash)
    else
      rack_component.update_attributes!(rack_component_hash)
    end
    rack_component
  end
end
