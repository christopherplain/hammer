require 'rails_helper'

RSpec.describe "LabelTemplates", type: :request do
  describe "GET /label_templates" do
    it "works! (now write some real specs)" do
      get label_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
