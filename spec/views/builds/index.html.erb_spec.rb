require 'rails_helper'

RSpec.describe "builds/index", type: :view do
  before(:each) do
    assign(:builds, [
      Build.create!(
        :build_type => "Build Type",
        :project_name => "Project Name",
        :project_reference => "Project Reference"
      ),
      Build.create!(
        :build_type => "Build Type",
        :project_name => "Project Name",
        :project_reference => "Project Reference"
      )
    ])
  end

  it "renders a list of builds" do
    render
    assert_select "tr>td", :text => "Build Type".to_s, :count => 2
    assert_select "tr>td", :text => "Project Name".to_s, :count => 2
    assert_select "tr>td", :text => "Project Reference".to_s, :count => 2
  end
end
