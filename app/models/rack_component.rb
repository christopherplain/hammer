class RackComponent
  include Mongoid::Document
  include Mongoid::Timestamps
  field :u_location, type: Integer
  field :orientation, type: String
  field :u_size, type: Integer
  field :sku, type: String
  embedded_in :elevation

  # Create manual relation to Part
  field :part_id, type: BSON::ObjectId

  def part
    Part.find(self.part_id) if self.part_id
  end

  def self.field_keys
    RackComponent.fields.keys.drop(3)
  end

  def self.update(row_hash, elevation)
    # Grab rack component data and search for existing RackComponent.
    rack_component_hash = row_hash.slice(*RackComponent.field_keys)
    u_location = rack_component_hash["u_location"].to_i
    orientation = rack_component_hash["orientation"]
    part_number = row_hash["part_number"]
    rack_component = elevation.rack_components.where(
      u_location: u_location, orientation: orientation).first
    part = Part.where(part_number: part_number).first
    if part
      rack_component_hash[:part_id] = part.id
    else
      rack_component_hash[:part_id] = nil
    end

    # Create new RackComponent or update existing document.
    if rack_component.nil?
      return elevation.rack_components.create!(rack_component_hash)
    else
      rack_component.update_attributes!(rack_component_hash)
      return rack_component
    end
  end
end
