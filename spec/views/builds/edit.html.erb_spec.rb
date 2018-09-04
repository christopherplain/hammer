require 'rails_helper'

RSpec.describe "builds/edit", type: :view do
  before(:each) do
    @build = assign(:build, Build.create!(
      :build_type => "MyString",
      :project_name => "MyString",
      :project_reference => "MyString"
    ))
  end

  it "renders the edit build form" do
    render

    assert_select "form[action=?][method=?]", build_path(@build), "post" do

      assert_select "input[name=?]", "build[build_type]"

      assert_select "input[name=?]", "build[project_name]"

      assert_select "input[name=?]", "build[project_reference]"
    end
  end
end
