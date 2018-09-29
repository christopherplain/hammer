class Component
  include Mongoid::Document
  include Mongoid::Timestamps
  field :row_order, type: String
  field :allocation, type: String
  field :u_location, type: String
  field :orientation, type: String
  field :u_size, type: String
  field :component_type, type: String
  field :manufacturer, type: String
  field :model, type: String
  field :sku, type: String
  field :hostname, type: String
  embedded_in :component_part, polymorphic: true

  ALLOCATION = ["Rack", "Accessory Kit", "Discrete"]

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.import(row_hash, parent)
    # Grab rack component data and search for existing Component.
    component_hash = row_hash.slice(*Component.field_keys)
    component = parent.components.where(id: row_hash["_id"]).first

    # Create new Component or update existing document.
    return parent.components.create(component_hash) if component.nil?
    component.update_attributes(component_hash)
    component
  end
end
