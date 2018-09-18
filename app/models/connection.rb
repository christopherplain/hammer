class Connection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :connection_group, type: String
  field :connection_type, type: String
  field :source_port, type: String
  field :destination_port, type: String
  field :cable_type, type: String
  field :cable_color, type: String
  field :cable_length, type: String
  field :row_order, type: String
  embedded_in :rack_config

  # Create manual relations to RackComponent
  field :source_device_id, type: BSON::ObjectId
  field :destination_device_id, type: BSON::ObjectId

  def source_device
    rack_config.rack_components.find(self.source_device_id) if source_device_id
  end

  def destination_device
    rack_config.rack_components.find(self.destination_device_id) if destination_device_id
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.update(row_hash, rack_config, n)
    # Grab connection data and return nil if no data.
    source_u = row_hash["source_u#{n}"]
    return nil if source_u.nil?
    source_orientation = row_hash["source_orientation#{n}"]
    source = rack_config.rack_components.where(u_location: source_u, orientation: source_orientation).first

    destination_u = row_hash["u_location"]
    destination_orientation = row_hash["orientation"]
    destination = rack_config.rack_components.where(u_location: destination_u, orientation: destination_orientation).first

    connection_keys = self.field_keys.map { |key| key + n.to_s }
    connection_hash = row_hash.slice(*connection_keys).transform_keys { |key| key[/^([^\d])+/] }
    connection_hash[:destination_device_id] = destination.id
    connection_hash[:source_device_id] = source.id

    # Create new Connection document.
    return rack_config.connections.create(connection_hash)
  end
end
