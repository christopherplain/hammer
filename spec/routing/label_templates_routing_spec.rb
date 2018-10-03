require "rails_helper"

RSpec.describe LabelTemplatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/label_templates").to route_to("label_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/label_templates/new").to route_to("label_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/label_templates/1").to route_to("label_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/label_templates/1/edit").to route_to("label_templates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/label_templates").to route_to("label_templates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/label_templates/1").to route_to("label_templates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/label_templates/1").to route_to("label_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/label_templates/1").to route_to("label_templates#destroy", :id => "1")
    end

  end
end
