class Api::V1::Merchants::InvoicesController <ApplicationController
  def show
    invoices = Invoice.find_all(params[:merchant_id])

    if invoices
      render json: InvoiceSerializer.new(invoices)
    else
      return render json: { error: "Invoices not found" }, status: :not_found
    end
  end
end