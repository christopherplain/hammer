require "rails_helper"

RSpec.describe RackConfigsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rack_configs").to route_to("rack_configs#index")
    end

    it "routes to #new" do
      expect(:get => "/rack_configs/new").to route_to("rack_configs#new")
    end

    it "routes to #show" do
      expect(:get => "/rack_configs/1").to route_to("rack_configs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rack_configs/1/edit").to route_to("rack_configs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rack_configs").to route_to("rack_configs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rack_configs/1").to route_to("rack_configs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rack_configs/1").to route_to("rack_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rack_configs/1").to route_to("rack_configs#destroy", :id => "1")
    end

  end
end
