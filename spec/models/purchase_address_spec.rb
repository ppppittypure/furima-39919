require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
   describe '住所の保存' do
    before do
      user = FactoryBot.create(:user)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'priceとtokenがあれば保存ができること' do
        expect(@purchase_address).to be_valid
        
      end
      
      it 'building_nameは空でも保存できること' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @purchase_address.prefecture = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'priceが空だと保存できないこと' do
        @purchase_address.price = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが全角数字だと保存できないこと' do
        @purchase_address.price = '２０００'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Price is invalid')
      end
      it 'priceが1円未満では保存できないこと' do
        @purchase_address.price = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Price is invalid')
      end
      it 'priceが1,000,000円を超過すると保存できないこと' do
        @purchase_address.price = 1000001
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Price is invalid')
      end
      it 'userが紐付いていないと保存できないこと' do
        @dpurchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it "municipalitiesは空では保存できないこと" do
        @purchase_address.price = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it "street_addressは空では保存できないこと" do
        @purchase_address.price = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
      end
      it "tokenが空では登録できないこと" do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end

