class LabelTemplate
  include Mongoid::Document
  include Mongoid::Timestamps
  field :group_name, type: String
  field :template_a, type: String
  field :template_b, type: String
  embedded_in :build

  VARIABLES = [
    "%<sh>s (source device hostname}",
    "%<su>s (source device u location)",
    "%<sp>s (source port)",
    "%<dh>s (destination device hostname)",
    "%<du>s (destination device u location)",
    "%<dp>s (destination port)"
  ]

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.generate(build)
    connection_groups = build.rack_config.connections.distinct(:group_name)
    connection_groups.each do |group|
      template = build.label_templates.where(group_name: group).first
      build.label_templates.create(group_name: group) if template.nil?
    end
  end
end
