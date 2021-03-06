require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, product_id: @product.id)
    sleep(0.1)
  end

  describe '配送先住所' do
    context '配送先住所が登録できる場合' do
      it '郵便番号・都道府県・市区町村・番地・建物名・電話番号・トークンがあれば配送先住所が登録されること' do
        expect(@purchase_address).to be_valid
      end
      it '建物名がなくても登録されること' do
        @purchase_address.building_name = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '配送先住所が登録できない場合' do
      it '郵便番号がなければ配送先住所が登録できないこと' do
        @purchase_address.postal_code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にはハイフンがなければ登録できないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県がなければ配送先住所が登録できないこと' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村がなければ配送先住所が登録できないこと' do
        @purchase_address.municipality = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地がなければ配送先住所が登録できないこと' do
        @purchase_address.address = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号がなければ配送先住所が登録できないこと' do
        @purchase_address.phone_number = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が10桁以下であれば登録できないこと' do
        @purchase_address.phone_number = '090123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が11桁以上であれば登録できないこと' do
        @purchase_address.phone_number = '090123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号にハイフンあれば登録できないこと' do
        @purchase_address.phone_number = '090-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が英数混合では登録できないこと' do
        @purchase_address.phone_number = '0a1b2c3e4f5'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では登録できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'product_idが空では登録できないこと' do
        @purchase_address.product_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end