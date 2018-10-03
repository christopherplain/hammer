require 'rails_helper'

RSpec.describe "label_templates/edit", type: :view do
  before(:each) do
    @label_template = assign(:label_template, LabelTemplate.create!(
      :name => "MyString",
      :template_a => "MyString",
      :template_b => "MyString"
    ))
  end

  it "renders the edit label_template form" do
    render

    assert_select "form[action=?][method=?]", label_template_path(@label_template), "post" do

      assert_select "input[name=?]", "label_template[name]"

      assert_select "input[name=?]", "label_template[template_a]"

      assert_select "input[name=?]", "label_template[template_b]"
    end
  end
end
