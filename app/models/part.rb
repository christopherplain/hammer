class Part
  include Mongoid::Document
  include Mongoid::Timestamps
  field :part_number, type: String
  field :manufacturer, type: String
  field :model, type: String
  field :description, type: String

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash

      # Determine and set the document type.
      doc_type = row_hash["doc_type"].downcase

      case doc_type
      when "part"
        update_part(row_hash)
      end
    end
  end

  def self.update_part(row_hash)
    # Grab part data and search for existing Part.
    part_hash = row_hash.slice(*Part.fields.keys.drop(3))
    part_number = part_hash["part_number"]
    part = Part.where(part_number: part_number)

    # Create new Part or update existing docuement.
    if part.first.nil?
      Part.create!(part_hash)
    else
      part.first.update_attributes!(part_hash)
    end
  end
end
