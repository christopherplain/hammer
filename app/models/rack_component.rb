class RackComponent
  include Mongoid::Document
  include Mongoid::Timestamps
  field :component_type, type: String
  field :u_location, type: Integer
  field :orientation, type: String
  field :u_size, type: Integer
  field :sku, type: String
  field :scan_serial, type: Boolean
  field :row_order, type: Integer
  embedded_in :rack_config

  # Create manual relation to Part
  field :part_id, type: BSON::ObjectId

  def part
    Part.find(self.part_id) if self.part_id
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.update(row_hash, rack_config)
    # Grab rack component data and search for existing RackComponent.
    rack_component_hash = row_hash.slice("id", *RackComponent.field_keys)
    rack_component = rack_config.rack_components.where(id: rack_component_hash["id"]).first
    part_number = row_hash["part_number"]
    part = Part.where(part_number: part_number).first
    rack_component_hash[:part_id] = part ? part.id : nil

    # Create new RackComponent or update existing document.
    return rack_config.rack_components.create!(rack_component_hash) if rack_component.nil?
    rack_component.update_attributes!(rack_component_hash)
    rack_component
  end
end
