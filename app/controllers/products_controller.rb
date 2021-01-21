class ProductsController < ApplicationController
  #before_action :authenticate_user!, only: [:destroy, :new, :edit]
  before_action :move_to_index, only: [:edit, :update, :destroy]#except: [:index, :show]
  def index
    @products = Product.order("created_at DESC")
  end

  def new
    @product = Product.new

  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:image, :name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
