class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about, :items]
  def top
    @items = Item.all
  end

  def about
  end
end
