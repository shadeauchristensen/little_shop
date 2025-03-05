require 'rails_helper'

RSpec.describe "Items API", type: :request do
    describe "GET /api/v1/items" do
        it "returns all items in the table" do
            items = create_list(:item, 3)

            get "/api/v1/items"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data].count).to eq(3)
        end
    end

    describe "GET /api/v1/items/{{item_id}}" do
        it "returns a specific item by its id" do
            item = create(:item)

            get "/api/v1/items/#{item.id}"

            expect(response).to be_successful
        end

        it "returns a 404 error if item does not exist" do
            get "/api/v1/items/1"

            expect(response).to have_http_status(:not_found)

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:error]).to eq("Item not found")
        end
    end

    describe "POST /api/v1/items" do
        it "can create a new item" do
            item = create(:item)

            post "/api/v1/items", params: {name: item[:name], 
            description: item[:description],
            unit_price: item[:unit_price],
            merchant_id: item[:merchant_id]
            }
            
            expect(response).to be_successful

            created_item = JSON.parse(response.body, symbolize_names: true)
            
            expect(created_item[:data][:attributes][:name]).to be_a(String)
            expect(created_item[:data][:attributes][:description]).to be_a(String)
            expect(created_item[:data][:attributes][:unit_price]).to be_a(Float)
            expect(created_item[:data][:attributes][:merchant_id]).to be_a(Integer)
        end
    end

    describe "PATCH /api/v1/items/{{item_id}}" do
        it "can update an existing item" do
            item = create(:item)
           
            patch "/api/v1/items/#{item.id}", params: { name: "NewString"}
            
            expect(response).to be_successful

            updated_item = Item.find_by(id: item.id)

            expect(updated_item[:name]).to_not eq(item[:name])

            expect(updated_item[:name]).to eq("NewString")
        end

        it "returns a 404 error if item does not exist" do
            patch "/api/v1/items/1", params: { name: "NewString"}
  
            expect(response).to_not be_successful
            
            expect(response.status).to eq(404)

            parsed_error = JSON.parse(response.body, symbolize_names: true)
            
            expect(parsed_error[:message]).to be_a(String)
            expect(parsed_error[:errors]).to be_a(Array)
            expect(parsed_error[:errors][0]).to be_a(String)
        end
    end
end

RSpec.describe "Merchant's items API", type: :request do
    describe "GET /api/v1/merchants/{{merchant_id}}/items" do
        it "Returns the Merchants Items from merchant_id" do
            merchant = create(:merchant)
            items = create_list(:item, 3, merchant: merchant)

            get "/api/v1/merchants/#{merchant.id}/items"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data].count).to eq(3)
            expect(parsed[:data].first[:attributes][:merchant_id]).to eq(merchant.id)
        end

        it "returns a 404 error if the merchant does not exist" do
            get "/api/v1/merchants/999999/items"

            expect(response).to have_http_status(:not_found)

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:error]).to eq("Merchant not found")
        end
    end
end