module Api
  module V1
          class MerchantInvoicesController < ApplicationController

              def index
                  merchant = Merchant.find_by(id: params[:merchant_id])
                  if merchant
                      render json: InvoiceSerializer.new(merchant.invoices)
                  else
                      return render json: { error: "Merchant not found" }, status: :not_found
                  end
              end
          end
  end
end