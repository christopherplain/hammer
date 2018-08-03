require 'rails_helper'

RSpec.describe "Elevations", type: :request do
  describe "GET /elevations" do
    it "works! (now write some real specs)" do
      get elevations_path
      expect(response).to have_http_status(200)
    end
  end
end
