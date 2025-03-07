class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :merchant_id, presence: true
end