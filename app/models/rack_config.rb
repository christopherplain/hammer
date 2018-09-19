class RackConfig
  require 'csv'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :sku, type: String
  field :notes, type: String
  embeds_many :rack_components
  embeds_many :connections
  has_many :builds
  belongs_to :customer
  validates :sku, presence: true

  def self.import(file, rack_config)
    # Create/update RackComponents.
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      RackComponent.update(row_hash, rack_config)
    end

    # Create Connections.
    rack_config.connections.destroy_all

    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      (1..100).each do |n|
        connection = Connection.update(row_hash, rack_config, n)
        break if connection.nil?
      end
    end
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end
end
