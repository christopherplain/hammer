class Build
  include Mongoid::Document
  include Mongoid::Timestamps
  field :build_type, type: String
  field :sales_order, type: String
  field :related_orders, type: String
  field :project_name, type: String
  field :project_reference, type: String
  field :notes, type: String
  embeds_many :asset_numbers
  embeds_many :cable_labels
  embeds_many :components, as: :component_part
  embeds_many :label_templates
  embeds_many :serial_numbers
  belongs_to :customer
  belongs_to :rack_config, optional: true
  accepts_nested_attributes_for :asset_numbers, :cable_labels, :label_templates, :serial_numbers
  validates :build_type, :sales_order, :project_name, presence: true

  BUILDTYPE = ["Rack", "Table"]

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def self.import(file, build)
    # Create/update Components.
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      allocation = row_hash["allocation"]
      build_component = allocation.eql?("Accessory Kit") || allocation.eql?("Discrete")

      Component.import(row_hash, build) if build_component
      AssetNumber.import(row_hash, build) if row_hash["expected_asset"]
      SerialNumber.import(row_hash, build) if row_hash["scan_serial"]
    end
    LabelTemplate.generate(build)
    CableLabel.generate(build)
  end

  def export
    CSV.generate(headers: true) do |csv|
      headers = ["_id", *Component.field_keys, "expected_asset", "scan_serial"]
      csv << headers

      components = self.rack_config.components.order(row_order: :asc)
      components.merge!(self.components.order(row_order: :asc))
      components.each do |component|
        row_hash = {}
        row_hash.merge!(component.attributes)
        asset_number = self.asset_numbers.where(component_id: component["id"]).first
        serial_number = self.asset_numbers.where(component_id: component["id"]).first
        row_hash["expected_asset"] = asset_number.expected_asset if asset_number
        row_hash["scan_serial"] = true if serial_number
        csv << row_hash.values_at(*headers)
      end
    end
  end
end
