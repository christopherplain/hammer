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

  def self.field_keys
    Connection.fields.keys.drop(3)
  end
end
