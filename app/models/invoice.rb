class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.filter_by_merchant_and_status(id, status)
    filtered_invoices = Invoice.joins(:merchant).where("merchant_id = ?", id).distinct
    if status 
      return filtered_invoices.select{|invoice| invoice.status === status}
    else
      return filtered_invoices
    end
  end

end