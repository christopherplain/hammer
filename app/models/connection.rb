class Connection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :local_u, type: Integer
  field :local_orientation, type: String
  field :local_port, type: String
  field :remote_u, type: Integer
  field :remote_orientation, type: String
  field :remote_port, type: String
  field :cable_type, type: String
  field :cable_color, type: String
  field :cable_length, type: String
  embedded_in :interface

  # Create manual relations to RackComponent
  field :local_device_id, type: BSON::ObjectId
  field :remote_device_id, type: BSON::ObjectId

  def rack_config
    self.interface.rack_config
  end

  def local_device
    rack_config.elevation.rack_component.find(self.local_device_id) if local_device_id
  end

  def remote_device
    rack_config.elevation.rack_component.find(self.remote_device_id) if remote_device_id
  end

  def self.field_keys
    Connection.fields.keys.drop(3)
  end
end
