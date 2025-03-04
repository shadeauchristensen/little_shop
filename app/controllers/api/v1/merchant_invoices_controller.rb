module Api
    module V1
        class MerchantInvoicesController < ApplicationController
            def index
                merchant = Merchant.find_by(id: params[:merchant_id])
                if merchant
                    merchant_invoices = Invoice.filter_by_merchant_and_status(merchant.id, params[:status])
                    render json: InvoiceSerializer.new(merchant_invoices)
                else
                    return render json: { error: "Merchant not found" }, status: :not_found
                end
            end
        end
    end
end