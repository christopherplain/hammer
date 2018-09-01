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
    # Create/update Elevation and RackComponents
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      elevation = update_elevation(row_hash, rack_config)
      RackComponent.update(row_hash, elevation)
    end

    # Create/update Interfaces and Connections
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      (1..100).each do |n|
        interface = Interface.update(row_hash, rack_config, n)
        break if interface.nil?
        Connection.update(row_hash, interface, n)
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
end
