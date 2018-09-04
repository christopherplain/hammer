require 'rails_helper'

RSpec.describe "builds/new", type: :view do
  before(:each) do
    assign(:build, Build.new(
      :build_type => "MyString",
      :project_name => "MyString",
      :project_reference => "MyString"
    ))
  end

  it "renders new build form" do
    render

    assert_select "form[action=?][method=?]", builds_path, "post" do

      assert_select "input[name=?]", "build[build_type]"

      assert_select "input[name=?]", "build[project_name]"

      assert_select "input[name=?]", "build[project_reference]"
    end
  end
end
