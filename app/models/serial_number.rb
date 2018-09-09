class SerialNumber
  include Mongoid::Document
  include Mongoid::Timestamps
  field :num, type: String
  embedded_in :build

  # Create manual relation to RackComponent
  field :rack_component_id, type: BSON::ObjectId

  def rack_component
    build.rack_config.rack_components.find(self.rack_component_id) if self.rack_component_id
  end

  # Return array of SerialNumber documents for scan form
  def self.prep_scan(build)
    serial_numbers = {}

    rack = build.rack_config.rack_components.where(component_type: 'rack',
      scan_serial: true).first
    serial_numbers[:rack] = build_serial_number(build, rack)

    front = build.rack_config.rack_components.where(orientation: 'front',
      scan_serial: true).order_by(u_location: :desc)
    serial_numbers[:front] = []
    front.each do |component|
      serial_numbers[:front] << build_serial_number(build, component)
    end

    rear = build.rack_config.rack_components.where(orientation: 'rear',
      scan_serial: true).order_by(u_location: :desc)
    serial_numbers[:rear] = []
    rear.each do |component|
      serial_numbers[:rear] << build_serial_number(build, component)
    end

    zero_u = build.rack_config.rack_components.where(u_location: 0,
      scan_serial: true).order_by(orientation: :asc)
    serial_numbers[:zero_u] = []
    zero_u.each do |component|
      serial_numbers[:zero_u] << build_serial_number(build, component)
    end

    return serial_numbers
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  private

    def self.build_serial_number(build, component)
      serial_number = build.serial_numbers.where(rack_component_id: component.id).first
      return build.serial_numbers.build(serial_number.attributes) if serial_number
      build.serial_numbers.build(rack_component_id: component.id)
    end
end
