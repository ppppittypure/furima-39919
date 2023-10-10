class PurchaseAddress
    include ActiveModel::Model
    attr_accessor :item, :user, :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number, :purchase, :token, :user_id
    validates :token, presence: true
    
    def save
  # 寄付情報を保存し、変数purchaseに代入する
  purchase = Purchase.create(user_id: user_id)
  # 住所を保存する
  
  Purchase.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalitie, street_address: street_address, building_name: building_name, purchase_id: purchase.id)
  end

end
