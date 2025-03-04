module Api
  module V1
          class MerchantCustomersController < ApplicationController
              def index
                  merchant = Merchant.find_by(id: params[:merchant_id])
                  if merchant
                    merchant_customers = Customer.filter_by_merchant_id(merchant.id)
                    render json: CustomerSerializer.new(merchant_customers)
                  else
                    return render json: { error: "Merchant not found" }, status: :not_found
                  end
              end
          end
  end
end