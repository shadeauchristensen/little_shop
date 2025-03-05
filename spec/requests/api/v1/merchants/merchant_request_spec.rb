require 'rails_helper'

RSpec.describe "Merchant API", type: :request do
    describe "GET /api/v1/merchants" do
        it "Returns all merchants in the table" do
            Merchant.destroy_all
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

            expect(parsed[:data][:attributes][:name]).to eq(merchant.name)
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

            post "/api/v1/merchants", params: {name: merchant.name}
            
            expect(response).to be_successful

            created_merchant = JSON.parse(response.body, symbolize_names: true)
            
            expect(created_merchant[:data][:attributes][:name]).to be_a(String)
        end

        it "returns an error if attributes are not included" do
            post "/api/v1/merchants"
            
            expect(response).to_not be_successful
            
            parsed_error = JSON.parse(response.body, symbolize_names: true)
        
            expect(parsed_error[:message]).to be_a(String)
            expect(parsed_error[:errors]).to be_a(Array)
            expect(parsed_error[:errors][0]).to be_a(String)
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

        it "returns a 404 error if merchant does not exist" do
          patch "/api/v1/merchants/1", params: { name: "NewString"}
            
            expect(response).to_not be_successful
            
            parsed_error = JSON.parse(response.body, symbolize_names: true)
            
            expect(parsed_error[:message]).to be_a(String)
            expect(parsed_error[:errors]).to be_a(Array)
            expect(parsed_error[:errors][0]).to be_a(String)
        end
    end
    
end

RSpec.describe "Merchant's Customers API", type: :request do
    describe "GET /api/v1/merchants/:merchant_id/customers" do
        it "Returns the Merchants Customers from merchant_id" do
            merchant = create(:merchant)
            customer = create(:customer)
            invoices = create_list(:invoice, 3, customer: customer, merchant: merchant)

            get "/api/v1/merchants/#{merchant.id}/customers"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data].count).to eq(1)
            expect(parsed[:data].first[:type]).to eq('customer')
        end

        it "returns a 404 error if the merchant does not exist" do
            get "/api/v1/merchants/999999/customers"

            expect(response).to have_http_status(:not_found)

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:error]).to eq("Merchant not found")
        end
    end
end

RSpec.describe "Merchant's Invoices API", type: :request do
    describe "GET /api/v1/merchants/:merchant_id/invoices" do
        it "Returns the Merchants Invoices from merchant_id" do
            merchant = create(:merchant)
            customer = create(:customer)
            invoices = create_list(:invoice, 3, customer: customer, merchant: merchant)

            get "/api/v1/merchants/#{merchant.id}/invoices"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data].count).to eq(3)
            expect(parsed[:data].first[:type]).to eq('invoice')
            expect(parsed[:data].first[:attributes][:merchant_id]).to eq(merchant.id)
        end

        it "returns a 404 error if the merchant does not exist" do
            get "/api/v1/merchants/999999/invoices"

            expect(response).to have_http_status(:not_found)

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:error]).to eq("Merchant not found")
        end
    end
end

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