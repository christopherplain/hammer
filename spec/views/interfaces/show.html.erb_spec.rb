require 'rails_helper'

RSpec.describe "interfaces/show", type: :view do
  before(:each) do
    @interface = assign(:interface, Interface.create!(
      :interface_group => "Interface Group",
      :interface_type => "Interface Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Interface Group/)
    expect(rendered).to match(/Interface Type/)
  end
end
