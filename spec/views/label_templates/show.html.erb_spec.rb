require 'rails_helper'

RSpec.describe "label_templates/show", type: :view do
  before(:each) do
    @label_template = assign(:label_template, LabelTemplate.create!(
      :name => "Name",
      :template_a => "Format A",
      :template_b => "Format B"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Format A/)
    expect(rendered).to match(/Format B/)
  end
end
