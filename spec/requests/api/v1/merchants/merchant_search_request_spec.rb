require "rails_helper"

RSpec.describe "Merchant Search Request", type: :request do
    describe "/api/v1/merchants/find" do
        before :each do
            @merchant1 = create(:merchant, name: "Turing Mart")
            @merchant2 = create(:merchant, name: "Ring World")
            @merchant3 = create(:merchant, name: "NonExistent")
        end

        it "Happy path, finds first merchant the meets search terms (case-insensitive)" do
            get "/api/v1/merchants/find?name=Mart"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed[:data]).to have_key(:id)
            expect(parsed[:data][:attributes][:name]).to eq("Turing Mart")
        end


        it "Sad path, returns empty if there is no merchant found" do
            get "/api/v1/merchants/find?name=unknown"

            expect(response).to be_successful

            parsed = JSON.parse(response.body, symbolize_names: true)

            expect(parsed).to eq({ data: {} })
        end

        it "Edge case, returns a 400 error if the name parameter is missing" do
            get "/api/v1/merchants/find"
    
            expect(response).to have_http_status(:bad_request)
            parsed = JSON.parse(response.body, symbolize_names: true)
    
            expect(parsed[:error]).to eq("Name should not be empty")
        end
    end
end