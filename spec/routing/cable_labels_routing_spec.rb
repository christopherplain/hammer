require "rails_helper"

RSpec.describe CableLabelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cable_labels").to route_to("cable_labels#index")
    end

    it "routes to #new" do
      expect(:get => "/cable_labels/new").to route_to("cable_labels#new")
    end

    it "routes to #show" do
      expect(:get => "/cable_labels/1").to route_to("cable_labels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cable_labels/1/edit").to route_to("cable_labels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cable_labels").to route_to("cable_labels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cable_labels/1").to route_to("cable_labels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cable_labels/1").to route_to("cable_labels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cable_labels/1").to route_to("cable_labels#destroy", :id => "1")
    end

  end
end
