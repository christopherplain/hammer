require 'rails_helper'

RSpec.describe "connections/show", type: :view do
  before(:each) do
    @connection = assign(:connection, Connection.create!(
      :connection_type => "Connection Type",
      :local_port => "Local Port",
      :remote_port => "Remote Port",
      :cable_type => "Cable Type",
      :cable_color => "Cable Color",
      :cable_length => "Cable Length"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Connection Type/)
    expect(rendered).to match(/Local Port/)
    expect(rendered).to match(/Remote Port/)
    expect(rendered).to match(/Cable Type/)
    expect(rendered).to match(/Cable Color/)
    expect(rendered).to match(/Cable Length/)
  end
end
