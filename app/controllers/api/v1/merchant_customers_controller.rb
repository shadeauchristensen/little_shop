module Api
  module V1
          class MerchantCustomersController < ApplicationController

              def index
                  merchant = Merchant.find_by(id: params[:merchant_id])
                  if merchant
                      render json: CustomerSerializer.new(merchant.customers)
                  else
                      return render json: { error: "Merchant not found" }, status: :not_found
                  end
              end
          end
  end
end