class OrdersController < ApplicationController

    before_action :authenticate_user!
    before_action :require_same_user, only: [:destroy]
    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def create
        @item = Item.find(params[:item_id])
        if current_user.id != @item.user_id 
            @order = Order.new(user_id: current_user.id, item_id: params[:item_id])
            if @order && @order.save
                flash[:notice] = 'Added to cart successfully!'
            else
                flash[:alert] = 'Somthing went wrong!' 
            end
        else
            flash[:alert] = "You can't buy you own product!"
        end
        redirect_back fallback_location: items_path
    end

    def destroy
        order = Order.where(item_id: params[:id], user_id: current_user.id).first
        if order && order.destroy
            flash[:notice] = "Successfully removed from cart!"
        else
            flash[:alert] = 'Something went wrong!'
        end
        redirect_back fallback_location: items_path
    end



    private

    def require_same_user
        order = Order.where(item_id: params[:id], user_id: current_user.id).first
        if current_user != order.user
          flash[:notice] = "This action is forbidden for you!"
          redirect_to root_path
        end
    end

end







# def create 
#     @order = Order.new(user_id: current_user.id, item_id: params[:item_id])
#     if @order && @order.save
#         respond_to do |format|
#             format.js {render partial: 'items/items-result'} 
#             format.html {render partial: 'items/items-result', notice: 'Added to cart successfully'} 
#         end
#     else
#         respond_to do |format| 
#             format.js { head :no_content}
#             # format.html {render partial: 'items/items-result'}
#             flash.now[:alert] = 'Something went wrong!'
#         end  
#     end
    
# end

# def destroy
#     order = Order.where(item_id: params[:id], user_id: current_user.id).first
#     if order && order.destroy
#         respond_to do |format|
#             format.js {render partial: 'items/items-result'} 
#             format.html {render partial: 'items/items-result', notice: 'Added to cart successfully'}
#         end
#     else
#         respond_to do |format| 
#             # format.html {render partial: 'items/items-result'}
#             format.js { head :no_content}
#             flash.now[:alert] = 'Something went wrong!'
#         end
#     end

# end
