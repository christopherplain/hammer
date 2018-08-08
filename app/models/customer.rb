class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  has_many :rack_configs
end
