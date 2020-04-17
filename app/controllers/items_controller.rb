class ItemsController < ApplicationController
    
    def index
        @items = Item.all
    end

    def new
        @item = Item.new
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



      
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @bug = Item.find(params[:id]) rescue not_found
  end
  # Only allow a list of trusted parameters through.
  def item_params
    
    params.require(:item).permit(:name, :price, :picture)
  end


end