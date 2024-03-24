require "rails_helper"

RSpec.describe VitalsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/vitals").to route_to("vitals#index")
    end

    it "routes to #new" do
      expect(get: "/vitals/new").to route_to("vitals#new")
    end

    it "routes to #show" do
      expect(get: "/vitals/1").to route_to("vitals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/vitals/1/edit").to route_to("vitals#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/vitals").to route_to("vitals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/vitals/1").to route_to("vitals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/vitals/1").to route_to("vitals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/vitals/1").to route_to("vitals#destroy", id: "1")
    end
  end
end
