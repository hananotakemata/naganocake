class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_show_item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item_new = CartItem.new
  end

  def edit
    @item =Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if@item.update(item_params)
    redirect_to admin_show_item_path(@item.id)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price)
  end
end
