class AssetNumber
  include Mongoid::Document
  include Mongoid::Timestamps
  field :row_order, type: String
  field :expected_asset, type: String
  field :scanned_asset, type: String
  embedded_in :build
  validates :component, presence: true
  validate :validate_scanned, on: :update

  # Create manual relation to Component
  field :component_id, type: BSON::ObjectId

  def component
    build.rack_config.components.find(self.component_id) if self.component_id
  end

  def self.field_keys
    self.fields.keys.drop(3)
  end

  def validate_scanned
    unless self.scanned_asset.blank? || self.validated?
      return self.errors.add(:scanned_asset, "does not equal expected_asset")
    end
  end

  def validated?
    self.scanned_asset.eql?(self.expected_asset)
  end

  # Import asset numbers from CSV
  def self.import(file, build)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      # Grab asset number data and search for existing AssetNumber.
      asset_hash = row_hash.slice(*AssetNumber.field_keys)
      asset_hash[:component_id] = row_hash["id"]
      asset_number = build.asset_numbers.where(component_id: asset_hash["component_id"]).first

      # Create new AssetNumber or update existing document.
      build.asset_numbers.create(asset_hash) if asset_hash["expected_asset"] && asset_number.nil?
      asset_number.update_attributes(asset_hash) if asset_hash["expected_asset"] && asset_number
    end
  end
end
