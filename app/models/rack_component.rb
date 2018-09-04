class RackComponent
  include Mongoid::Document
  include Mongoid::Timestamps
  field :component_type, type: String
  field :u_location, type: Integer
  field :orientation, type: String
  field :u_size, type: Integer
  field :sku, type: String
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
    rack_component_hash = row_hash.slice(*RackComponent.field_keys)
    u_location = rack_component_hash["u_location"].to_i
    orientation = rack_component_hash["orientation"]
    part_number = row_hash["part_number"]
    rack_component = rack_config.rack_components.where(
      u_location: u_location, orientation: orientation).first
    part = Part.where(part_number: part_number).first
    rack_component_hash[:part_id] = part.id if part
    rack_component_hash[:part_id] = nil unless part

    # Create new RackComponent or update existing document.
    return rack_config.rack_components.create!(rack_component_hash) if rack_component.nil?
    rack_component.update_attributes!(rack_component_hash)
    rack_component
  end
end
