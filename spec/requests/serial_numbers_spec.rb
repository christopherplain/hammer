require 'rails_helper'

RSpec.describe "SerialNumbers", type: :request do
  describe "GET /serial_numbers" do
    it "works! (now write some real specs)" do
      get serial_numbers_path
      expect(response).to have_http_status(200)
    end
  end
end
