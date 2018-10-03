require 'rails_helper'

RSpec.describe "cable_labels/new", type: :view do
  before(:each) do
    assign(:cable_label, CableLabel.new())
  end

  it "renders new cable_label form" do
    render

    assert_select "form[action=?][method=?]", cable_labels_path, "post" do
    end
  end
end
