class OrdersController < ApplicationController

    def index
        @order = Order.all
    end

    def create 
        @order = Order.new(user_id: current_user.id, item_id: params[:item_id])
        if @order && @order.save
            flash[:notice] = 'Added to cart successfully'
        else
            flash[:alert] = 'Somthing went wrong' 
        end
        redirect_to items_path
    end
end