class PurchasesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_public_key, only: [:index, :create]
    def index
        @purchase_address = PurchaseAddress.new
        @item = Item.find(params[:item_id])
        if @item.purchase.present? || current_user.id == @item.user_id
            redirect_to root_path
        end

    end


    def create
        @purchase_address = PurchaseAddress.new(purchase_params)
        @item = Item.find(params[:item_id])
        if @purchase_address.valid?
            pay_item
           
        @purchase_address.save
        redirect_to root_path
    else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        render "index", status: :unprocessable_entity
    end
end

    private

    def purchase_params
       params.require(:purchase_address).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token]) 
    end

    def pay_item
        Payjp.api_key = ENV["PAYJP_SECRET_KEY"]# 自身のPAY.JPテスト秘密鍵を記述しましょう
        Payjp::Charge.create(
            amount: @item.price,  # 商品の値段
            card: purchase_params[:token],    # カードトークン
            currency: "jpy", # 通貨の種類（日本円）
        )
    end

    def set_public_key
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    end

    #def address_params
        #params.permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number).merge(purchase_id: @purchase.id)
    #end
end
