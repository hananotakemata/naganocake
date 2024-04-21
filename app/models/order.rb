class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  attribute :postal_code, :string
  attribute :address, :string
  attribute :name, :string
  attribute :billing_amount, :integer
  enum payment_method: { credit_card: 0, transfer: 1 }
end
