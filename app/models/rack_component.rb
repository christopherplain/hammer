class RackComponent
  include Mongoid::Document
  include Mongoid::Timestamps
  field :u_location, type: Integer
  field :orientation, type: String
  field :u_size, type: Integer
  field :part_number, type: String
  field :sku, type: String
  embedded_in :elevation
  references_one :part
end
