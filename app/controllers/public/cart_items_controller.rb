class Public::CartItemsController < ApplicationController
  def index
    @cart_item = current_customer.cart_items
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cartitem = CartItem.find(params[:id])
    @cartitem.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def create
    cart_item = current_customer.cart_items.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item.item_id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to public_cart_items_path
    else
      cart_item.save
      redirect_to public_cart_items_path
    end


  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
