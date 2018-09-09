require "rails_helper"

RSpec.describe SerialNumbersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/serial_numbers").to route_to("serial_numbers#index")
    end

    it "routes to #new" do
      expect(:get => "/serial_numbers/new").to route_to("serial_numbers#new")
    end

    it "routes to #show" do
      expect(:get => "/serial_numbers/1").to route_to("serial_numbers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/serial_numbers/1/edit").to route_to("serial_numbers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/serial_numbers").to route_to("serial_numbers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/serial_numbers/1").to route_to("serial_numbers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/serial_numbers/1").to route_to("serial_numbers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/serial_numbers/1").to route_to("serial_numbers#destroy", :id => "1")
    end

  end
end
