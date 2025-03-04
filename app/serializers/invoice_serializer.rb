class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :customer_id, :mechant_id, :status
end