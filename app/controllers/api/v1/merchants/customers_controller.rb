class Api::V1::Merchants::CustomersController < ApplicationController
  def show
    customers = Customer.find_all(params[:merchant_id])

    if customers
      render json: CustomerSerializer.new(customers)
    else
      return render json: { error: "Customers not found" }, status: :not_found
    end
  end
end
