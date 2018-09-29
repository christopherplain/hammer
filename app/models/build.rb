class Build
  include Mongoid::Document
  include Mongoid::Timestamps
  field :build_type, type: String
  field :project_name, type: String
  field :project_reference, type: String
  embeds_many :asset_numbers
  embeds_many :components, as: :component_part
  embeds_many :serial_numbers
  belongs_to :customer
  belongs_to :rack_config, optional: true
  accepts_nested_attributes_for :asset_numbers, :serial_numbers
  validates :build_type, :project_name, presence: true

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
  end
end
