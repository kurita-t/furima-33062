class ProductsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:image).merge(user_id: current_user.id)
  end
end
