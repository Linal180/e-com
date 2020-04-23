class LikesController < ApplicationController

    def index
        @favorites = Like.where(user: current_user)
    end


    def create
        @item = Item.find(params[:id])
        if @item.user_id != current_user.id 
            @liked_item = Like.new(user_id: current_user.id, item_id: params[:id])
            if @liked_item && @liked_item.save
                flash[:notice] = 'Added to favorites successfully!'
            else
                flash[:alert] = 'Somthing went wrong!' 
            end
        else
            flash[:alert] = "You can't like your own product!"
        end
        redirect_back fallback_location: items_path

    end

    def destroy
        item = Like.where(item_id: params[:id], user_id: current_user.id).first
        if item && item.destroy
            flash[:notice] = "Successfully removed from favorites"        
        else
            flash[:alert] = 'Something went wrong'
        end
        redirect_back fallback_location: items_path

    
    end
end