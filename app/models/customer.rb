class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  has_many :builds
  has_many :rack_configs

  def self.field_keys
    self.fields.keys.drop(3)
  end
end
