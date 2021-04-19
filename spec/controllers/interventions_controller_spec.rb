require 'rails_helper'
require 'json'

describe InterventionsController, type: :controller do
    
    describe "checking on different function in the Intervention Controller when they are called" do
        # by sending a customerid = 1 as params to pick buildings belonging to that customer
        context "verifies that the getbuildings function in the intervention controller works correctly" do
            it "Return buildings associated to a customer_id" do
                params = {
                    "custormerid" => 1
                }
                get :getbuildings, params: params,  format: :json
                res = JSON.parse(response.body).first
                expect(res["id"]).to eq(1)
            end
        end
        # by sending a buildingid = 1 as params to pick batteries belonging to that buildingv
        context "verifies that the getbatteries function in the intervention controller works correctly" do
            it "Return batteries associated to a customer_id" do
                params = {
                    "buildingid" => 1
                }
                get :getbatteries, params: params,  format: :json
                res = JSON.parse(response.body).first
                expect(res["id"]).to eq(1)
            end
        end    
    end
end