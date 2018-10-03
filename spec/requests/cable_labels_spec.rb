require 'rails_helper'

RSpec.describe "CableLabels", type: :request do
  describe "GET /cable_labels" do
    it "works! (now write some real specs)" do
      get cable_labels_path
      expect(response).to have_http_status(200)
    end
  end
end
