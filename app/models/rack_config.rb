class RackConfig
  require 'csv'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :sku, type: String
  embeds_many :rack_components
  embeds_many :connections
  belongs_to :customer

  def self.field_keys
    RackConfig.fields.keys.drop(3)
  end

  def self.import(file, rack_config)
    # Create/update RackComponents.
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      RackComponent.update(row_hash, rack_config)
    end

    # Create/update Connections.
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      (1..100).each do |n|
        connection = Connection.update(row_hash, rack_config, n)
        break if connection.nil?
      end
    end
  end
end
