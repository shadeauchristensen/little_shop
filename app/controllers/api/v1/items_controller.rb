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
        render json: Item.create(item_params)
    end
    
    def update
        render json: Item.update(params[:id], item_params)
    end
    
    private

    def item_params
        params.permit(:name, :description, :unit_price, :merchant_id)
    end
end