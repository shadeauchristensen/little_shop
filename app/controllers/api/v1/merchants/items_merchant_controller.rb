module Api
    module V1
        module Merchants
            class ItemsMerchantController < ApplicationController

                def index
                    merchant = Merchant.find_by(id: params[:merchant_id])
                    if merchant
                        render json: ItemSerializer.new(merchant.items)
                    else
                        return render json: { error: "Merchant not found" }, status: :not_found
                    end
                end
            end
        end
    end
end
