class ProductsController < ApplicationController
  before_action :move_to_index, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update]

  def index
    @products = Product.all.order('created_at DESC')
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

  def edit
  end

  def show
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @product.user_id
      @product.destroy
      redirect_to root_path
    else
      redirect_to :show
    end
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:image, :name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                    :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def ensure_current_user
    redirect_to action: :index if @product.user_id != current_user.id || @product.product_purchase.present?
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
