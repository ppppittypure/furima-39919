class Purchase < ApplicationRecord
    belongs_to :user
    belongs_to :item
    has_one :address

    # 1以上、1000000以下の整数を許可する
    #validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: "is invalid"}

end
