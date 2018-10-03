require 'rails_helper'

RSpec.describe "label_templates/new", type: :view do
  before(:each) do
    assign(:label_template, LabelTemplate.new(
      :name => "MyString",
      :template_a => "MyString",
      :template_b => "MyString"
    ))
  end

  it "renders new label_template form" do
    render

    assert_select "form[action=?][method=?]", label_templates_path, "post" do

      assert_select "input[name=?]", "label_template[name]"

      assert_select "input[name=?]", "label_template[template_a]"

      assert_select "input[name=?]", "label_template[template_b]"
    end
  end
end
