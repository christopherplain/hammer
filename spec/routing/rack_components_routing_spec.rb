require "rails_helper"

RSpec.describe RackComponentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rack_components").to route_to("rack_components#index")
    end

    it "routes to #new" do
      expect(:get => "/rack_components/new").to route_to("rack_components#new")
    end

    it "routes to #show" do
      expect(:get => "/rack_components/1").to route_to("rack_components#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rack_components/1/edit").to route_to("rack_components#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rack_components").to route_to("rack_components#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rack_components/1").to route_to("rack_components#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rack_components/1").to route_to("rack_components#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rack_components/1").to route_to("rack_components#destroy", :id => "1")
    end

  end
end
