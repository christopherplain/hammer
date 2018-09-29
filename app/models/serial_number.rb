class SerialNumber
  include Mongoid::Document
  include Mongoid::Timestamps
  field :row_order, type: String
  field :serial, type: String
  embedded_in :build
  validates :component, presence: true

  # Create manual relation to Component
  field :component_id, type: BSON::ObjectId

  def component
    rack_component = build.rack_config.components.where(id: self.component_id).first
    return rack_component if rack_component
    return build.components.where(id: self.component_id).first
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  # Import serial numbers from CSV
  def self.import(row_hash, build)
    # Grab serial number data and search for existing SerialNumber.
    serial_hash = row_hash.slice(*SerialNumber.field_keys)
    serial_hash[:component_id] = row_hash["_id"]
    serial_number = build.serial_numbers.where(component_id: row_hash["_id"]).first

    # Create new SerialNumber or update existing document.
    return build.serial_numbers.create(serial_hash) if serial_number.nil?
    serial_number = serial_number.update_attributes(serial_hash)
    serial_number
  end
end
