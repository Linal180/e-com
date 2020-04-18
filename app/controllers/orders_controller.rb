class OrdersController < ApplicationController

    def index
        @orders = Order.all
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

    def destroy
        order = Order.where(item_id: params[:id], user_id: current_user.id).first
        if order && order.destroy
            flash[:notice] = "Successfully removed from cart"
        else
            flash[:alert] = 'Something went wrong'
        end
        redirect_to items_path
    end
end