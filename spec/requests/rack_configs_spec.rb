require 'rails_helper'

RSpec.describe "RackConfigs", type: :request do
  describe "GET /rack_configs" do
    it "works! (now write some real specs)" do
      get rack_configs_path
      expect(response).to have_http_status(200)
    end
  end
end
