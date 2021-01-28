require 'rails_helper'

RSpec.describe "ProductPurchases", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/product_purchases/index"
      expect(response).to have_http_status(:success)
    end
  end

end
