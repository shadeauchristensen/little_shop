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
        params.permit(:name)
    end
end