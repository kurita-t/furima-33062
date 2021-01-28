class ProductPurchasesController < ApplicationController
  def index
    @purchase_address = PurchaseAddress.new
    @product = Product.find(params[:product_id])
  end

  def create
    @product = Product.find(params[:product_id])
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to action: :index
    else
      render action: :index
    end
  end

  private
  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
