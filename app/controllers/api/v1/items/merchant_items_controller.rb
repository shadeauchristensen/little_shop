module Api
    module V1 
        module Items
            class MerchantItemsController < ApplicationController
                def show
                    item = Item.find_by(id: params[:item_id])

                    if item
                        render json: MerchantSerializer.new(item.merchant)
                    else
                        return render json: { error: "Item not found" }, status: :not_found
                    end
                end
            end
        end
    end
end