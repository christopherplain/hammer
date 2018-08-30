class Interface
  include Mongoid::Document
  include Mongoid::Timestamps
  field :interface_group, type: String
  field :interface_type, type: String
  embeds_many :connections
  embedded_in :rack_config

  def self.field_keys
    Interface.fields.keys.drop(3)
  end
end
