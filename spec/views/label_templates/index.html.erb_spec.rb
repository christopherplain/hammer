require 'rails_helper'

RSpec.describe "label_templates/index", type: :view do
  before(:each) do
    assign(:label_templates, [
      LabelTemplate.create!(
        :name => "Name",
        :template_a => "Format A",
        :template_b => "Format B"
      ),
      LabelTemplate.create!(
        :name => "Name",
        :template_a => "Format A",
        :template_b => "Format B"
      )
    ])
  end

  it "renders a list of label_templates" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Format A".to_s, :count => 2
    assert_select "tr>td", :text => "Format B".to_s, :count => 2
  end
end
