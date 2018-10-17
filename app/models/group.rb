class Group
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  has_many :users

  index({ name: 1 }, { unique: true, name: "name_index" })

  def self.field_keys
    self.fields.keys.drop(3)
  end
end
