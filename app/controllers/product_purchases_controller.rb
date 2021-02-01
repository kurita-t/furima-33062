class ProductPurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user
  before_action :purchased_products

  def index
    @purchase_address = PurchaseAddress.new
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_order
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, product_id: params[:product_id], token: params[:token]
    )
  end

  def pay_order
  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: Product.find(params[:product_id]).price,
        card: purchase_address_params[:token],
        currency: 'jpy'
      )
  end

  def ensure_current_user
    @product = Product.find(params[:product_id])
    redirect_to root_path if @product.user_id == current_user.id
  end

  def purchased_products
    if @product.product_purchase.present?
      redirect_to root_path
    end
  end
end
