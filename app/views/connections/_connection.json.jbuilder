json.extract! connection, :id, :connection_type, :local_port, :remote_port, :cable_type, :cable_color, :cable_length, :created_at, :updated_at
json.url connection_url(connection, format: :json)
