require 'rails_helper'

RSpec.describe "Item Find_all Search Request", type: :request do
    describe "GET /api/v1/items/find_all" do
        before :each do
            Item.destroy_all 
            Merchant.destroy_all

            @merchant = create(:merchant)
            @item1 = create(:item, name: "Ring of Power", unit_price: 50, merchant: @merchant)
            @item2 = create(:item, name: "Magic Wand", unit_price: 75, merchant: @merchant)
            @item3 = create(:item, name: "Healing Potion", unit_price: 150, merchant: @merchant)
        end
      
        it "Happy Path, returns all items that meet search terms (case-insensitive)" do
            get "/api/v1/items/find_all?name=ring" 

            expect(response).to be_successful
            parsed = JSON.parse(response.body, symbolize_names: true)
        
            expect(parsed[:data].size).to eq(1)
            expect(parsed[:data].first[:attributes][:name]).to eq("Ring of Power")
        end

        it "Happy Path, returns all items within a price range" do
            get "/api/v1/items/find_all?min_price=25&max_price=75"
      
            expect(response).to be_successful
            parsed = JSON.parse(response.body, symbolize_names: true)
      
            expect(parsed[:data].size).to eq(2)
        end

        it "Sad Path, returns a 400 if min_price is less than 0" do
            get "/api/v1/items/find_all?min_price=-1"
        
            expect(response.status).to eq(400)
            parsed = JSON.parse(response.body, symbolize_names: true)
            expect(parsed[:errors]).to eq(["Invalid search parameters: min_price cannot be negative"])
        end
        
        it "Sad Path, returns a 400 if max_price is less than 0" do
            get "/api/v1/items/find_all?max_price=-1"
        
            expect(response.status).to eq(400)
            parsed = JSON.parse(response.body, symbolize_names: true)
            expect(parsed[:errors]).to eq(["Invalid search parameters: max_price cannot be negative"])
        end
        
        it "Edge Case, returns a 400 if no params are given" do
            get "/api/v1/items/find_all"
        
            expect(response.status).to eq(400)
            parsed = JSON.parse(response.body, symbolize_names: true)
            expect(parsed[:errors]).to eq(["Invalid search parameters: name or price filter required"])
        end
        
        it "Edge Case, returns a 400 if name fragment is empty" do
            get "/api/v1/items/find_all?name="
        
            expect(response.status).to eq(400)
            parsed = JSON.parse(response.body, symbolize_names: true)
            expect(parsed[:errors]).to eq(["Invalid search parameters: name or price filter required"])
        end
    end
end
