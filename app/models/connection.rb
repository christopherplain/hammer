class Connection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :row_order, type: String
  field :group_type, type: String
  field :group_num, type: String
  field :group_name, type: String
  field :source_port, type: String
  field :destination_port, type: String
  field :transceiver, type: String
  field :cable_type, type: String
  field :cable_color, type: String
  field :cable_length, type: String
  embedded_in :rack_config

  # Create manual relations to RackComponent
  field :source_device_id, type: BSON::ObjectId
  field :destination_device_id, type: BSON::ObjectId

  def source_device
    rack_config.rack_components.find(self.source_device_id) if source_device_id
  end

  def destination_device
    rack_config.rack_components.find(self.destination_device_id) if destination_device_id
  end

  def self.humanize_type(group_type)
    case group_type
    when "net"
      return "network"
    when "pwr"
      return "power"
    when "stor"
      return "storage"
    when "misc"
      return "miscellaneous"
    end
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.csv_keys(rack_config)
    keys = self.field_keys
    keys.shift(3)
    keys.pop(2)
    keys.insert(1, "source_u")
    keys.insert(2, "source_orientation")

    prefixes = []
    connections = rack_config.connections
    connections.each do |connection|
      prefixes << "#{connection.group_type}_#{connection.group_num}"
    end
    prefixes = prefixes.uniq.sort_by { |p|
      p.start_with?("net") ? "1#{p.split('_')[1]}" :
      p.start_with?("misc") ? "2#{p.split('_')[1]}" :
      p.start_with?("stor") ? "3#{p.split('_')[1]}" : "4#{p.split('_')[1]}"
    }

    prefixed_keys = []
    prefixes.each do |prefix|
      prefixed_keys << keys.map { |key| "#{prefix}-#{key}"}
    end
    prefixed_keys.flatten
  end

  def self.import(row_hash, rack_config, prefixes)
    # Setup connection hash for document creation.
    prefixes.each do |prefix|
      source_u = row_hash["#{prefix}-source_u"]
      next if source_u.nil?
      source_orientation = row_hash["#{prefix}-source_orientation"]
      source = rack_config.rack_components.where(u_location: source_u, orientation: source_orientation).first

      destination_u = row_hash["u_location"]
      destination_orientation = row_hash["orientation"]
      destination = rack_config.rack_components.where(u_location: destination_u, orientation: destination_orientation).first

      group_type = prefix.split("_")[0]
      group_num = prefix.split("_")[1]

      connection_keys = self.field_keys.map { |key| "#{prefix}-#{key}" }
      connection_hash = row_hash.slice(*connection_keys).transform_keys { |key| key.split("-")[1] }
      connection_hash[:row_order] = destination_u
      connection_hash[:group_type] = group_type
      connection_hash[:group_num] = group_num
      connection_hash[:destination_device_id] = destination.id
      connection_hash[:source_device_id] = source.id

      # Create new Connection.
      rack_config.connections.create(connection_hash)
    end
  end
end
