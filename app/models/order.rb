class Order < ApplicationRecord

    belongs_to :user
    belongs_to :item


    def get_item_name(item_id)
        @item = Item.find(item_id)
        return "#{@item.name}"
    end

    def get_item_price(item_id)
        @item = Item.find(item_id)
        return "#{@item.price}"
    end

    
end