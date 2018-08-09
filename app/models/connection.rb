class Connection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :connection_type, type: String
  field :local_port, type: String
  field :remote_port, type: String
  field :cable_type, type: String
  field :cable_color, type: String
  field :cable_length, type: String
  embedded_in :rack_component

  def self.field_keys
    Connection.fields.keys.drop(3)
  end
end
