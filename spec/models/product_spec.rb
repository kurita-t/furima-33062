require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品の出品機能' do
    context "商品出品情報が登録できる場合" do
      it "name、description、category_id、condition_id、shipping_cost_id、prefecture_id、shipping_day_id、priceがあれば商品情報が登録される" do
        expect(@product).to be_valid
      end
      it "nameが40文字でも登録できること" do
        @product.name = "a" * 40
        expect(@product).to be_valid
      end
      it "descriptionが1000文字でも登録できること" do
        @product.description = "a" * 1000
        expect(@product).to be_valid
      end
      it "販売価格は半角数字のみ保存可能であること" do
        @product.price = '1000'
        expect(@product).to be_valid
      end
      it "priceが9999999以下だと登録できること" do
        @product.price = "999999"
        expect(@product).to be_valid
      end
    end

    context "商品出品情報が登録できない場合" do
      it "nameがない場合は登録できないこと" do
        @product.name = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
      it "nameが41文字だと登録できないこと" do
        @product.name = "a" * 41
        @product.valid?
        expect(@product.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it "descriptionがない場合は登録できないこと" do
        @product.description = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it "descriptionが1001文字だと登録できないこと" do
        @product.description = "a" * 1001
        @product.valid?
        expect(@product.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
      end
      it "category_idがない場合は登録できないこと" do
        @product.category_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Category is not a number")
      end
      it "category_idが1では登録できないこと" do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Category must be other than 1")
      end
      it "condition_idがない場合は登録できないこと" do
        @product.condition_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition is not a number")
      end
      it "condition_idが1では登録できないこと" do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition must be other than 1")
      end
      it "prefecture_idがない場合は登録できないこと" do
        @product.prefecture_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture is not a number")
      end
      it "prefecture_idが1では登録できないこと" do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it "shipping_day_idがない場合は登録できないこと" do
        @product.shipping_day_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping day is not a number")
      end
      it "shipping_day_idが1では登録できないこと" do
        @product.shipping_day_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping day must be other than 1")
      end
      it "priceがない場合は登録できないこと" do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it "priceが全角数字では登録できないこと" do
        @product.price = '１０００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
      it "priceが半角英数混合では登録できないこと" do
        @product.price = '11aa'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
      it "priceが半角英語だけでは登録できないこと" do
        @product.price = 'aaa'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
      it "priceが299以下だと登録できないこと" do
        @product.price = "299"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price must be greater than 299")
      end
      it "priceが10000000だと登録できないこと" do
        @product.price = "10000000"
        @product.valid?
        expect(@product.errors.full_messages).to include("Price must be less than 9999999")
      end
      it "画像が空では登録できないこと" do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
