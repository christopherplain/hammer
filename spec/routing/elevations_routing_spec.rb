require "rails_helper"

RSpec.describe ElevationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/elevations").to route_to("elevations#index")
    end

    it "routes to #new" do
      expect(:get => "/elevations/new").to route_to("elevations#new")
    end

    it "routes to #show" do
      expect(:get => "/elevations/1").to route_to("elevations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/elevations/1/edit").to route_to("elevations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/elevations").to route_to("elevations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/elevations/1").to route_to("elevations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/elevations/1").to route_to("elevations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/elevations/1").to route_to("elevations#destroy", :id => "1")
    end

  end
end
