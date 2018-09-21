class RackComponent
  include Mongoid::Document
  include Mongoid::Timestamps
  field :row_order, type: String
  field :u_location, type: String
  field :orientation, type: String
  field :u_size, type: String
  field :component_type, type: String
  field :manufacturer, type: String
  field :model, type: String
  field :sku, type: String
  field :hostname, type: String
  embedded_in :rack_config

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.import(row_hash, rack_config)
    # Grab rack component data and search for existing RackComponent.
    rack_component_hash = row_hash.slice(*RackComponent.field_keys)
    rack_component = rack_config.rack_components.where(id: row_hash["_id"]).first

    # Create new RackComponent or update existing document.
    return rack_config.rack_components.create(rack_component_hash) if rack_component.nil?
    rack_component.update_attributes(rack_component_hash)
    rack_component
  end
end
