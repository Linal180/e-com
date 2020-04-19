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


    def get_item_picture(item_id)
        @item = Item.find(item_id)
        return "#{@item.picture}"
    end


    def get_user_name(order_id)
        @order = Order.find(order_id)
        @user = User.find(@order.user_id)
        return "#{@user.first_name} #{@user.last_name}"
    end

    
    
end