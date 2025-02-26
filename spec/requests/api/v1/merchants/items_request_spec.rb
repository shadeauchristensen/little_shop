require 'rails_helper'

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
    end
end