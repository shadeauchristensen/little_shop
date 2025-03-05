require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe "class methods" do
    it "can filter invoices by merchant and status" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      id_1 = merchant1.id
      id_2 = merchant2.id

      customer = create(:customer)

      invoices1 = create_list(:invoice, 3, customer: customer, merchant: merchant1, status: "pending")
      invoices1_extra = create_list(:invoice, 4, customer: customer, merchant: merchant1, status: "incomplete")
      invoices2 = create_list(:invoice, 2, customer: customer, merchant: merchant2, status: "shipped")
      

      merchant1_invoices = Invoice.filter_by_merchant_and_status(id_1, "pending")
      merchant1_extra_invoices = Invoice.filter_by_merchant_and_status(id_1, "incomplete")
      merchant2_invoices = Invoice.filter_by_merchant_and_status(id_2, "shipped")
      
      expect(merchant1_invoices.count).to eq(3)
      expect(merchant1_invoices.first.merchant_id).to eq(id_1)

      expect(merchant1_extra_invoices.count).to eq(4)
      expect(merchant1_extra_invoices.first.merchant_id).to eq(id_1)

      expect(merchant2_invoices.count).to eq(2)
      expect(merchant2_invoices.first.merchant_id).to eq(id_2)
    end
  end
end