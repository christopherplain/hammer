require 'rails_helper'

RSpec.describe "serial_numbers/edit", type: :view do
  before(:each) do
    @serial_number = assign(:serial_number, SerialNumber.create!(
      :num => "MyString"
    ))
  end

  it "renders the edit serial_number form" do
    render

    assert_select "form[action=?][method=?]", serial_number_path(@serial_number), "post" do

      assert_select "input[name=?]", "serial_number[num]"
    end
  end
end
