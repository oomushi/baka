require "rails_helper"

RSpec.describe PollsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/polls").to route_to("polls#index")
    end

    it "routes to #show" do
      expect(:get => "/polls/1").to route_to("polls#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/polls").to route_to("polls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/polls/1").to route_to("polls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/polls/1").to route_to("polls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/polls/1").to route_to("polls#destroy", :id => "1")
    end
  end
end
