require "rails_helper"

RSpec.describe ClansController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/clans").to route_to("clans#index")
    end

    it "routes to #new" do
      pending 'auto generated non-running test.'
      expect(:get => "/clans/new").to route_to("clans#new")
    end

    it "routes to #show" do
      expect(:get => "/clans/1").to route_to("clans#show", :id => "1")
    end

    it "routes to #edit" do
      pending 'auto generated non-running test.'
      expect(:get => "/clans/1/edit").to route_to("clans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/clans").to route_to("clans#create")
    end

    it "routes to #update" do
      expect(:put => "/clans/1").to route_to("clans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/clans/1").to route_to("clans#destroy", :id => "1")
    end

  end
end
