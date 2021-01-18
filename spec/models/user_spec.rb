require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it "nicknameとemail、passwordとpassword_confirmation、family_nameとfirst_nameとfamily_name_kanaとfirst_name_kana、birth_dayが存在すれば登録できること" do
          expect(@user).to be_valid
        end

        it "passwordが6文字以上であれば登録できること" do
          @user.password = "123abc"
          @user.password_confirmation = "123abc"
          expect(@user).to be_valid
        end

      end

      context '新規登録がうまくいかないとき' do
        it "nicknameが空では登録できないこと" do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
    
        it "emailが空では登録できないこと" do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
    
        it "passwordが空では登録できないこと" do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it "passwordが5文字以下であれば登録できないこと" do
          @user.password = "123ab"
          @user.password_confirmation = "123ab"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end
    
        it "passwordが半角英数字混合でなければ登録できないこと(半角英字のみ)" do
          @user.password = "abcdef"
          @user.password_confirmation = "abcdef"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is invalid")
        end
    
        it "passwordが半角英数字混合でなければ登録できないこと(半角数字のみ)" do
          @user.password = "123456"
          @user.password_confirmation = "123456"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is invalid")
        end
    
        it "passwordとpassword_confirmationが不一致では登録できないこと" do
          @user.password = "123abc"
          @user.password_confirmation = "123abcd"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
    
        it "重複したemailが存在する場合登録できないこと" do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Email has already been taken")
        end
    
        it "お名前(名字)が空だと登録できないこと" do
          @user.family_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name can't be blank")
        end
    
        it "お名前(名前)が空だと登録できないこと" do
          @user.first_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end
    
        it "お名前(名字)は全角（漢字・ひらがな・カタカナ）でなければ登録できないこと" do
          @user.family_name = "kana"
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name is invalid")
        end
    
        it "お名前(名前)は全角（漢字・ひらがな・カタカナ）でなければ登録できないこと" do
          @user.first_name = "kana"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name is invalid")
        end
    
        it "フリガナ（名字）が空だと登録できない" do
          @user.family_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name kana can't be blank")
        end
    
        it "フリガナ（名前）が空だと登録できない" do
          @user.first_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end
    
        it "名字のフリガナは全角（カタカナ）でなければ登録できない" do
          @user.family_name_kana = "かな"
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name kana is invalid")
        end
    
        it "名前のフリガナは全角（カタカナ）でなければ登録できないこと" do
          @user.first_name_kana = "かな"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana is invalid")
        end
    
        it "生年月日が空だと登録できないこと" do
          @user.birth_day = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth day can't be blank")
        end

      end
    end
  end
end
