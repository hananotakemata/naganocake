class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.all

  end

  def new_confirmation
    @order = current_customer.orders.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = current_customer.full_name
    end
    @order.postage = 800
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.delivery_name = current_customer.full_name
    @cart_items = current_customer.cart_items
    total_price = @cart_items.sum(&:subtotal)
    total_price += @order.postage
    @order.billing_amount = total_price
    @order_new = Order.new
    render :new_confirmation
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.delivery_name = current_customer.first_name + current_customer.last_name
    @order.address = current_customer.address
    @order.customer_id = current_customer.id
    @order.postal_code = current_customer.postal_code
    @cart_items = current_customer.cart_items

    total_price = @cart_items.sum(&:subtotal)
    total_price += @order.postage
    @order.billing_amount = total_price

    @order_new = Order.new
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new
          @order_detail.item_id = cart_item.item_id
          @order_detail.quantity = cart_item.amount
          @order_detail.purchase_price = cart_item.item.price
          @order_detail.subtotal = cart_item.subtotal
          @order_detail.save
      end
      current_customer.cart_items.destroy_all

      redirect_to public_show_order_path(@order)
    else
      render :new_confirmation
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
  end

  def show_details
    
    @order = Order.find(params[:id])
    order_id = @order.id
    @order_details = OrderDetail.where(order_id: order_id)

     @sum = 0
     @order_details.each do |order_detail|
       @sum += order_detail.subtotal
    end

     @total_amount = @sum + @order.postage
  end


  private
   def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_address, :postage, :customer_id, :delivery_name)
   end

   def clear_cart
    current_customer.cart_items.destroy_all
   end
end
