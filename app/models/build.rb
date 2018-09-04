class Build
  include Mongoid::Document
  include Mongoid::Timestamps
  field :build_type, type: String
  field :project_name, type: String
  field :project_reference, type: String
  belongs_to :customer
  belongs_to :rack_config, optional: true
  validates :build_type, :project_name, presence: true

  BUILDTYPE = { Rack: "rack", Table: "table" }

  def self.field_keys
    self.fields.keys.drop(3)
  end
end
