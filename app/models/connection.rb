class Connection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :connection_group, type: String
  field :connection_type, type: String
  field :local_port, type: String
  field :remote_port, type: String
  field :cable_type, type: String
  field :cable_color, type: String
  field :cable_length, type: String
  embedded_in :rack_config

  # Create manual relations to RackComponent
  field :local_device_id, type: BSON::ObjectId
  field :remote_device_id, type: BSON::ObjectId

  def local_device
    rack_config.rack_components.find(self.local_device_id) if local_device_id
  end

  def remote_device
    rack_config.rack_components.find(self.remote_device_id) if remote_device_id
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.update(row_hash, rack_config, n)
    # Grab connection data and search for existing Connection.
    local_u = row_hash["u_location"]
    local_orientation = row_hash["orientation"]
    local = rack_config.rack_components.where(u_location: local_u, orientation: local_orientation).first

    remote_u = row_hash["remote_u#{n}"]
    remote_orientation = row_hash["remote_orientation#{n}"]
    remote = rack_config.rack_components.where(u_location: remote_u, orientation: remote_orientation).first

    connection_keys = self.field_keys.map { |key| key + n.to_s }
    connection_hash = row_hash.slice(*connection_keys).transform_keys { |key| key[/^([^\d])+/] }
    connection_hash[:local_device_id] = local.id
    connection_hash[:remote_device_id] = remote.id

    local_port = connection_hash["local_port"]
    connection = rack_config.connections.where(local_device_id: local.id, local_port: local_port).first

    # Create new Connection or update existing document.
    return rack_config.connections.create!(connection_hash) if connection.nil? && local_port
    connection.update_attributes!(connection_hash) if connection && local_port
    connection
  end
end
