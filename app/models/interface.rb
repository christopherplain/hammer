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

  def self.update(row_hash, rack_config, n)
    # Grab interface data and search for existing Interface.
    interface_keys = self.field_keys.map { |key| key + n.to_s }
    interface_hash = row_hash.slice(*interface_keys).transform_keys { |key| key[/^([^\d])+/] }
    interface_group = interface_hash["interface_group"]
    interface = rack_config.interfaces.where(interface_group: interface_group).first

    # Create new Interface or update existing document.
    if interface.nil? && interface_group
      return rack_config.interfaces.create!(interface_hash)
    elsif interface_group
      interface.update_attributes!(interface_hash)
      return interface
    end
  end
end
