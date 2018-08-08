class RackComponent
  include Mongoid::Document
  include Mongoid::Timestamps
  field :u_location, type: Integer
  field :orientation, type: String
  field :u_size, type: Integer
  field :sku, type: String
  embedded_in :elevation
  has_and_belongs_to_many :parts, inverse_of: nil

  def self.field_keys
    RackComponent.fields.keys.drop(3)
  end
end
