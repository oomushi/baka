require "rails_helper"

RSpec.describe ChoicesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/choices").to route_to("choices#index")
    end

    it "routes to #show" do
      expect(:get => "/choices/1").to route_to("choices#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/choices").to route_to("choices#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/choices/1").to route_to("choices#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/choices/1").to route_to("choices#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/choices/1").to route_to("choices#destroy", :id => "1")
    end
  end
end
