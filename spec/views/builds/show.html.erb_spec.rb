require 'rails_helper'

RSpec.describe "builds/show", type: :view do
  before(:each) do
    @build = assign(:build, Build.create!(
      :build_type => "Build Type",
      :project_name => "Project Name",
      :project_reference => "Project Reference"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Build Type/)
    expect(rendered).to match(/Project Name/)
    expect(rendered).to match(/Project Reference/)
  end
end
