require 'rails_helper'

RSpec.describe "AssetNumbers", type: :request do
  describe "GET /asset_numbers" do
    it "works! (now write some real specs)" do
      get asset_numbers_path
      expect(response).to have_http_status(200)
    end
  end
end
