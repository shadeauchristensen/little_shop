class Api::V1::MerchantsController < ApplicationController
    def index
        render json: MerchantSerializer.new(Merchant.all)
    end

    def show
        merchant = Merchant.find_by(id: params[:id])
        if merchant
            render json: MerchantSerializer.new(merchant)
        else
            render json: { error: "Merchant not found" }, status: :not_found
        end
    end

    def create
        render json: Merchant.create(merchant_params)
    end
    
    def update
        render json: Merchant.update(params[:id], merchant_params)
    end
    
    private

    def merchant_params
        params.permit(:name)
    end
end