class ItemsController < ApplicationController
    

    before_action :require_same_user, only: [:edit, :destroy, :update]
    before_acrion :require_admin, only [:create, :destroy, :edit, :update]
    def index
        @items = Item.all
    end

    def new
        @item = Item.new
    end 

    def edit
    
    end

    def show

    end

    def create
        @item = Item.new(item_params)
        @item.user = current_user
        if @item && @item.save
            flash[:notice] = "Item was created successfully"
            redirect_to items_path
        else
            flash[:alert] = 'Something went wrong white creating new item'
            render 'new'
        end
    end

    def destroy
    
    end

      
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id]) rescue not_found
  end
  # Only allow a list of trusted parameters through.
  def item_params
    
    params.require(:item).permit(:name, :price, :picture)
  end


  def require_same_user
      order = Order.where(item_id: params[:id], user_id: current_user.id).first
      if current_user != @item.user
        flash[:notice] = "This action is forbidden for you!"
        redirect_to root_path
      end
  end


end