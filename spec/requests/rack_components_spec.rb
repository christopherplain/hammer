require 'rails_helper'

RSpec.describe "RackComponents", type: :request do
  describe "GET /rack_components" do
    it "works! (now write some real specs)" do
      get rack_components_path
      expect(response).to have_http_status(200)
    end
  end
end
