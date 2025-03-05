require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
  end

  describe "class methods" do
    it "can filter customers by merchant id" do
        merchant1 = create(:merchant)
        merchant2 = create(:merchant)
  
        id_1 = merchant1.id
        id_2 = merchant2.id
  
        customer1 = create(:customer)
        customer2 = create(:customer)
        customer3 = create(:customer)
        customer4 = create(:customer)

        invoice1 = create(:invoice, customer: customer1, merchant: merchant1)
        invoice2 = create(:invoice, customer: customer2, merchant: merchant1)
        invoice3 = create(:invoice, customer: customer3, merchant: merchant1)
        invoice4 = create(:invoice, customer: customer4, merchant: merchant1)
        
        invoice5 = create(:invoice, customer: customer1, merchant: merchant2)
        invoice6 = create(:invoice, customer: customer2, merchant: merchant2)
        
        merchant1_customers = Customer.filter_by_merchant_id(id_1)
        merchant2_customers = Customer.filter_by_merchant_id(id_2)

        expect(merchant1_customers.count).to eq(4)
        expect(merchant2_customers.count).to eq(2)
    end
  end
end