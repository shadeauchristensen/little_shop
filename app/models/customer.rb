class Customer < ApplicationRecord
    has_many :invoices

    def self.filter_by_merchant_id(params)
      Customer.joins(:invoices).where("merchant_id = #{params}").distinct
    end
end