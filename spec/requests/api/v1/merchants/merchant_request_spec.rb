require 'rails_helper'

RSpec.describe "Item's Merchant API", type: :request do
    describe "GET /api/v1/items/:id/merchant" do
        it "Returns the merchant for a given item" do
        merchant = create(:merchant)
        item = create(:item, merchant: merchant)

        get "/api/v1/items/#{item.id}/merchant"

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:data][:id].to_i).to eq(merchant.id)
        end

        it "returns a 404 error if the item does not exist" do
        get "/api/v1/items/999999/merchant"

        expect(response).to have_http_status(:not_found)

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:error]).to eq("Item not found")
        end
    end
end

RSpec.describe "Merchant API", type: :request do
    describe "GET /api/v1/merchants" do
        it "Returns all merchants in the table" do
            merchants = create_list(:merchant, 3)

            get "/api/v1/merchants"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data].count).to eq(3)
        end
    end

    describe "GET /api/v1/merchants/{{merchant_id}}" do
        it "returns a specific merchant by its id" do
            merchant = create(:merchant)

            get "/api/v1/merchants/#{merchant.id}"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data][:attributes][:name]).to eq("MyString")
        end

        it "returns a 404 error if merchant does not exist" do
            get "/api/v1/merchants/1"

            expect(response).to have_http_status(:not_found)

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:error]).to eq("Merchant not found")
        end
    end

    describe "POST /api/v1/merchants" do
        it "can create a new merchant" do
            merchant = create(:merchant)

            post "/api/v1/merchants", params: {name: merchant[:name]}
            
            expect(response).to be_successful

            created_merchant = JSON.parse(response.body, symbolize_names: true)
            
            expect(created_merchant[:data][:attributes][:name]).to be_a(String)
        end
    end

    describe "PATCH /api/v1/merchants/:id" do
        it "can update an existing merchant" do
            merchant = create(:merchant)
           
            patch "/api/v1/merchants/#{merchant.id}", params: { name: "NewString" }
            
            updated_merchant = Merchant.find_by(id: merchant.id)
          
            expect(response).to be_successful

            expect(updated_merchant[:name]).to_not eq("MyString")

            expect(updated_merchant[:name]).to eq("NewString")
        end
    end
    
end