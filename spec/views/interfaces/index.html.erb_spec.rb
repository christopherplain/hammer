require 'rails_helper'

RSpec.describe "interfaces/index", type: :view do
  before(:each) do
    assign(:interfaces, [
      Interface.create!(
        :interface_group => "Interface Group",
        :interface_type => "Interface Type"
      ),
      Interface.create!(
        :interface_group => "Interface Group",
        :interface_type => "Interface Type"
      )
    ])
  end

  it "renders a list of interfaces" do
    render
    assert_select "tr>td", :text => "Interface Group".to_s, :count => 2
    assert_select "tr>td", :text => "Interface Type".to_s, :count => 2
  end
end
