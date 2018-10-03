require 'rails_helper'

RSpec.describe "cable_labels/index", type: :view do
  before(:each) do
    assign(:cable_labels, [
      CableLabel.create!(),
      CableLabel.create!()
    ])
  end

  it "renders a list of cable_labels" do
    render
  end
end
