class NetworkConnection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :device1_port, type: String
  field :device2_port, type: String
  field :cable_type, type: String
  field :cable_color, type: String
  field :cable_length, type: String
  embedded_in :rack_config
  has_and_belongs_to_many :device1, class_name: :parts, inverse_of: nil
  has_and_belongs_to_many :device2, class_name: :parts, inverse_of: nil

  def self.field_keys
    NetworkConnection.fields.keys.drop(3)
  end
end
