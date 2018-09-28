class RackConfig
  require 'csv'
  include Mongoid::Document
  include Mongoid::Timestamps
  field :sku, type: String
  field :notes, type: String
  embeds_many :components, as: :component_part
  embeds_many :connections
  has_many :builds
  belongs_to :customer
  validates :sku, presence: true

  def self.import(file, rack_config)
    # Create/update Components.
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      Component.import(row_hash, rack_config)
    end

    # Create Connections.
    rack_config.connections.destroy_all

    headers = CSV.foreach(file.path).first
    connection_headers = []
    headers.each do |header|
      connection_headers << header if header.start_with?("net", "pwr", "stor", "misc")
    end

    prefixes = connection_headers.map { |header| header.split("-")[0] }
    prefixes = prefixes.uniq

    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      Connection.import(row_hash, rack_config, prefixes)
    end
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def export
    CSV.generate(headers: true) do |csv|
      connection_keys = Connection.csv_keys(self)
      headers = ["_id", *Component.field_keys, *connection_keys]
      csv << headers

      components = self.components.order(row_order: :asc)
      components.each do |component|
        row_hash = {}
        row_hash.merge!(component.attributes)

        connections = self.connections.where(destination_device_id: component["id"])
        connections.each do |connection|
          connection_hash = connection.attributes
          source_device = connection.source_device
          connection_hash["source_u"] = source_device.u_location
          connection_hash["source_orientation"] = source_device.orientation

          group_type = connection.group_type
          group_num = connection.group_num
          connection_hash = connection_hash.transform_keys { |key| "#{group_type}_#{group_num}-#{key}"}

          row_hash.merge!(connection_hash)
        end

        csv << row_hash.values_at(*headers)
      end
    end
  end
end
