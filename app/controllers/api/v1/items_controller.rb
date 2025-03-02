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

    def find_all
        begin 
            validate_item_params

            items = 
            if params[:name].present?
                Item.where("name ILIKE ?", "%#{params[:name]}%" ).order(:name)
            else
                filter_items_by_price
            end

            render json: ItemSerializer.new(items)

            rescue ArgumentError => e
                render json: { error: e.message }, status: :bad_request

            rescue StandardError => e
                render json: { error: "Something is wrong: #{e.message}" }, status: :internal_server_error
            end
        end
    end
    
    private

    def item_params
        params.permit(:name, :description, :unit_price, :merchant_id)
    end

    def validate_item_params
        if params[:name].present? && (params[:min_price].present? || params[:max_price].present?)
          raise ArgumentError, "Invalid search parameters: cannot combine the name and prices"

        if params[:name].present? && params[:name].strip.empty?
            raise ArgumentError, "Invalid search parameters: name cannot be empty"
        end
    end

    def filter_items_by_price
        min_price = params[:min_price].to_f if params[:min_price].present?
        max_price = params[:max_price].to_f if params[:max_price].present?

        query = Item.all
        query = query.where("unit_price >= ?", min_price) if min_price
        query = query.where("unit_price <= ?", max_price) if max_price
        query
    end
end