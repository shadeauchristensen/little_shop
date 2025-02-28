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
        begin
            merchant = Merchant.create({name: merchant_params})
        rescue StandardError => error
            render json: {errors: [error], message: error.message}, status: 400
            return
        end

        render json: MerchantSerializer.new(merchant), status: 201
    end
    
    def update
        begin
            merchant = Merchant.update(params[:id], {name: merchant_params})
        rescue StandardError => error
            render json: {errors: [error], message: error.message}, status: 404
            return
        end

        render json: MerchantSerializer.new(merchant), status: 201
    end
    
    private

    def merchant_params
        params.require(:name)
    end
end