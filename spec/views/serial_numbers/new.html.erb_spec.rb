require 'rails_helper'

RSpec.describe "serial_numbers/new", type: :view do
  before(:each) do
    assign(:serial_number, SerialNumber.new(
      :num => "MyString"
    ))
  end

  it "renders new serial_number form" do
    render

    assert_select "form[action=?][method=?]", serial_numbers_path, "post" do

      assert_select "input[name=?]", "serial_number[num]"
    end
  end
end
