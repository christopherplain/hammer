class CableLabel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :label_a, type: String
  field :label_b, type: String
  embedded_in :build

  # Create manual relations to Connection.
  field :connection_id, type: BSON::ObjectId

  def connection
    build.rack_config.connections.find(id: self.connection_id) if connection_id
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.generate(build)
    connections = build.rack_config.connections
    connections.each do |connection|
      label = build.cable_labels.where(connection_id: connection.id).first
      build.cable_labels.create(connection_id: connection.id) if label.nil?
    end
  end

  def template_var_hash
    return {
      sh: connection.source_device.hostname,
      su: connection.source_device.u_location,
      sp: connection.source_port,
      dh: connection.destination_device.hostname,
      du: connection.destination_device.u_location,
      dp: connection.destination_port
    }
  end
end
