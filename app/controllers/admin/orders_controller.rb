class Admin::OrdersController < ApplicationController
  def show
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
  end
end
