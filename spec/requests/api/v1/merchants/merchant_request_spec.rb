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