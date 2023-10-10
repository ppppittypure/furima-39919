class PurchasesController < ApplicationController
    before_action :authenticate_user!, except: :index
    def index
        @purchase_address = PurchaseAddress.new
        @item = Item.find(params[:item_id])
    end


    def create
        @purchase_address = PurchaseAddress.new(purchase_params)
        if @purchase_address.valid?
            pay_item
            Payjp.api_key = "sk_test_81c3238892b9919e88cf0b0d"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
            Payjp::Charge.create(
                amount: order_params[:price],  # 商品の値段
                card: order_params[:token],    # カードトークン
                currency: "jpy", # 通貨の種類（日本円）
)
        @purchase_address.save
        redirect_to root_path
    else
        
    end
end

    private

    def purchase_params
       params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number,:price).merge(user_id: current_user.id,token: params[:token]) 
    end

    def pay_item
        Payjp.api_key = "sk_test_81c3238892b9919e88cf0b0d"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
        Payjp::Charge.create(
            amount: order_params[:price],  # 商品の値段
            card: order_params[:token],    # カードトークン
            currency: "jpy", # 通貨の種類（日本円）
  )
end

    #def address_params
        #params.permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number).merge(purchase_id: @purchase.id)
    #end
end
