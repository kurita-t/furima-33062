class ProductPurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :product
  before_action :ensure_current_user

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
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
        amount: @product.price,
        card: purchase_address_params[:token],
        currency: 'jpy'
      )
  end

  def ensure_current_user
    if @product.user_id == current_user.id || @product.product_purchase.present?
      redirect_to root_path
    end
  end

  def product
    @product = Product.find(params[:product_id])
  end
end
