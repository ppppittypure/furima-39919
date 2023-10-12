class PurchaseAddress
    include ActiveModel::Model
    attr_accessor :item_id, :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number, :purchase, :token, :user_id
    #validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
    with_options presence: true do
      validates :item_id, :prefecture_id, :municipalities, :street_address, :token, :user_id,:telephone_number
      validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Post code is invalid. Include hyphen(-)" }
      validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
    end
    
    validates :prefecture_id,exclusion:{ in:[id: 0, name: '---'] }
  def save
  # 保存し、変数purchaseに代入する
    purchase = Purchase.create(user_id: user_id,item_id: item_id)
  # 住所を保存する
  
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, street_address: street_address, telephone_number: telephone_number, building_name: building_name, purchase_id: purchase.id)
  end

end
