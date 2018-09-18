json.extract! connection, :id, :connection_type, :destination_port, :source_port, :cable_type, :cable_color, :cable_length, :created_at, :updated_at
json.url connection_url(connection, format: :json)
