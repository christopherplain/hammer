require 'rails_helper'

RSpec.describe "serial_numbers/index", type: :view do
  before(:each) do
    assign(:serial_numbers, [
      SerialNumber.create!(
        :num => "Num"
      ),
      SerialNumber.create!(
        :num => "Num"
      )
    ])
  end

  it "renders a list of serial_numbers" do
    render
    assert_select "tr>td", :text => "Num".to_s, :count => 2
  end
end
