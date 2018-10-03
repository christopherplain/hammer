require 'rails_helper'

RSpec.describe "cable_labels/edit", type: :view do
  before(:each) do
    @cable_label = assign(:cable_label, CableLabel.create!())
  end

  it "renders the edit cable_label form" do
    render

    assert_select "form[action=?][method=?]", cable_label_path(@cable_label), "post" do
    end
  end
end
