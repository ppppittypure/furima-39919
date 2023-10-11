require "rails_helper"
# require "faker"

RSpec.describe PurchaseAddress, type: :model do
  describe "配送先情報の保存" do
    before do
      @item = FactoryBot.create(:item)
      @user = FactoryBot.create(:user)
      @purchase_address = FactoryBot.build(:purchase_address, item_id: @item.id, user_id: @user.id)
    end

    context "内容に問題ない場合" do
      it "すべての値が正しく入力されていれば保存できること" do
        expect(@purchase_address).to be_valid
      end
      it "building_nameは空でも保存できること" do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
    end

    context "内容に問題がある場合" do
      it "郵便番号が必須であること。" do
        @purchase_address.post_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank", "Post code is invalid. Include hyphen(-)")
      end
      it " 郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（良い例:123-4567 良くない例:1234567）。" do
        @purchase_address.post_code = "1234567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "都道府県が必須であること。" do
        @purchase_address.prefecture_id = ""
                          
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "市区町村が必須であること。" do
        @purchase_address.municipalities = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it "番地が必須であること。" do
        @purchase_address.street_address = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
      end
      it "電話番号が必須であること。" do
        @purchase_address.telephone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it "電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例:09012345678 良くない例:090-1234-5678)" do
        @purchase_address.telephone_number = "123456789234"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "電話番号が9桁以下だと購入できないこと" do
        @purchase_address.phone_number = "090123456"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "電話番号が半角数値でないと購入できないこと" do
        @purchase_address.telephone_number = "09012341234"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it "都道府県に「---」が選択されている場合は購入できないこと" do
        @purchase_address.prefecture_id = "1"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
            
      it "tokenが空では登録できないこと" do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it "user_idが紐づいていなければ購入できないこと" do
        @purchase_address.user_id = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it "item_idが紐づいていなければ購入できないこと" do
        @purchase_address.item_id = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
