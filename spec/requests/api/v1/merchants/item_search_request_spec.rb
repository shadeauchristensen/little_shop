RSpec.describe "Item Search Request", type: :request do
    describe "/api/v1/items/find_all" do
        before :each do
            @item1 = create(:item, name: "Ring of Power", unit_price: 50)
            @item2 = create(:item, name: "Magic Wand", unit_price: 75)
            @item3 = create(:item, name: "Healing Potion", unit_price: 25)
        end
    end

    it "returns all items that the meets search terms (case-insensitive)" do
        get "/api/v1/items/find_all?name=ring"

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:data])
    end
end


# not sure what to do here 
# i can find the ring as the name but make sure that whatever name im calling is following the prompt in the project page
# test to make sure that im following happy and sad paths and also hitting the edge cases
# reconsider whether or not Faker is helpful or harmful in this
# and check to see if the postman tests work. Ring of power may work still
# research how to test this properly before continuing and if needed restart the controller to do it right
# remember to TDD, this is what is fucking you here
# so far there are 4 tests not working. vvv

    #FAILED
        # sad path, min_price less than 0 | AssertionError: expected 200 to equal 400`
    # FAILED
        # sad path, max_price less than 0 | AssertionError: expected 200 to equal 400`  
    # FAILED
        # edge case, no param given | AssertionError: expected PostmanResponse{ …(10) } to have property 'code' of 400, but got 200
    # FAILED
        # edge case, name fragment is empty | AssertionError: expected PostmanResponse{ …(10) } to have property 'code' of 400, but got 200

# when you pick this back up, try and think about this and map out the goals to understand whats happening and where to go from here
