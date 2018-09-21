class Build
  include Mongoid::Document
  include Mongoid::Timestamps
  field :build_type, type: String
  field :project_name, type: String
  field :project_reference, type: String
  embeds_many :asset_numbers
  embeds_many :serial_numbers
  belongs_to :customer
  belongs_to :rack_config, optional: true
  accepts_nested_attributes_for :asset_numbers
  validates :build_type, :project_name, presence: true

  BUILDTYPE = { Rack: "Rack", Table: "Table" }

  def self.field_keys
    self.fields.keys.drop(3)
  end
end
