class CableLabel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :label_a, type: String
  field :label_b, type: String
  embedded_in :build

  # Create manual relations to Connection.
  field :connection_id, type: BSON::ObjectId

  def connection
    build.rack_config.connections.find(id: self.connection_id) if connection_id
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.generate(build)
    connections = build.rack_config.connections
    connections.each do |connection|
      label = build.cable_labels.where(connection_id: connection.id).first
      build.cable_labels.create(connection_id: connection.id) if label.nil?
    end
  end

  def template_var_hash
    return {
      sh: connection.source_device.hostname,
      su: connection.source_device.u_location,
      sp: connection.source_port,
      dh: connection.destination_device.hostname,
      du: connection.destination_device.u_location,
      dp: connection.destination_port
    }
  end

  def self.export(build)
    CSV.generate do |csv|
      connection_groups = build.rack_config.connections.distinct(:group_name)
      connection_groups.each do |group|
        csv << [group]

        template = build.label_templates.where(group_name: group).first
        template_a = template.template_a
        template_b = template.template_b

        connections = build.rack_config.connections.where(group_name: group)
        connections = connections.sort_by { |c| [
          -c.row_order.to_i,
          c.source_port.split("/")[0].to_i,
          c.source_port.split("/")[1].to_i
        ] }
        connections.each do |connection|
          label = build.cable_labels.where(connection_id: connection.id).first
          variables = label.template_var_hash

          if label.label_a.blank?
            csv << [template_a % variables]
          else
            csv << [label.label_a]
          end

          if label.label_b.blank?
            csv << [template_b % variables]
          else
            csv << [label.label_b]
          end
        end

        csv << []
      end
    end
  end
end
