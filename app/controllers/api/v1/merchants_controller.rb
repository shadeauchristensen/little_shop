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

    def find
        if params[:name].blank?
            render json: { error: "Name should not be empty" }, status: :bad_request
            return
        end

        begin
            # Rails.logger.info "Received name parameter: #{params[:name].inspect}"

            merchant = Merchant.where( "name ILIKE ?", "%#{params[:name]}%" ).order(:name).first

            if merchant.nil?
                render json: { data: {} }, status: :ok
            else
                render json: MerchantSerializer.new(merchant), status: :ok
            end

        rescue StandardError => e
            render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
        end
    end
    
    private

    def merchant_params
        params.require(:name)
    end
end