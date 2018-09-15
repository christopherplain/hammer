require "rails_helper"

RSpec.describe AssetNumbersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/asset_numbers").to route_to("asset_numbers#index")
    end

    it "routes to #new" do
      expect(:get => "/asset_numbers/new").to route_to("asset_numbers#new")
    end

    it "routes to #show" do
      expect(:get => "/asset_numbers/1").to route_to("asset_numbers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/asset_numbers/1/edit").to route_to("asset_numbers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/asset_numbers").to route_to("asset_numbers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/asset_numbers/1").to route_to("asset_numbers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/asset_numbers/1").to route_to("asset_numbers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/asset_numbers/1").to route_to("asset_numbers#destroy", :id => "1")
    end

  end
end
