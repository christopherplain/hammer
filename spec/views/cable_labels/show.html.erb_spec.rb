require 'rails_helper'

RSpec.describe "cable_labels/show", type: :view do
  before(:each) do
    @cable_label = assign(:cable_label, CableLabel.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
