require 'rails_helper'

RSpec.describe "serial_numbers/show", type: :view do
  before(:each) do
    @serial_number = assign(:serial_number, SerialNumber.create!(
      :num => "Num"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Num/)
  end
end
