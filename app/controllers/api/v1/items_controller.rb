class Api::V1::ItemsController < ApplicationController
    def index
        render json: ItemSerializer.new(Item.all)
    end

    def show
        item = Item.find_by(id: params[:id])
        if item
            render json: ItemSerializer.new(item)
        else
            render json: { error: "Item not found" }, status: :not_found
        end
    end

    def create
        begin
            item = Item.create(item_params)
        rescue StandardError => error
            render json: {errors: [error], message: error.message}
            return
        end

        render json: ItemSerializer.new(item), status: 201
    end
    
    def update
        begin
            item = Item.update(params[:id], item_params)
        rescue StandardError => error
            render json: {errors: [error], message: error.message}, status: 404
            return
        end

        render json: ItemSerializer.new(item), status: 201
    end
    
    private

    def item_params
        params.permit(:name, :description, :unit_price, :merchant_id)
    end
end