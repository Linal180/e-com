class ItemsController < ApplicationController
    
    rescue_from ActionView::MissingTemplate, :with => :not_found

    skip_before_action :authenticate_user!, only: [:index, :search]
    before_action :set_item, only: [:show, :destroy, :require_same_user]
    before_action :require_admin, only: [:new, :create, :edit, :destroy, :update]
    before_action :require_same_user, only: [:edit, :destroy, :update]

    def index
        @items = Item.all
        # respond_to do |format|
        #   format.html
        #   format.json
        # end
    end

    def new
        @item = Item.new
    end 

    def edit
    
    end

    def show
      @item = Item.find(params[:id])
    end

    def create
        @item = Item.new(item_params)
        @item.user = current_user
        if @item.save
            flash[:notice] = "Item was created successfully"
            redirect_to items_path
        else
            flash[:alert] = 'Something went wrong white creating new item'
            render 'new'
        end
    end

    def destroy
      @orders = Order.where(item_id: @item.id) 
      @likes = Like..where(item_id: @item.id)
      if @item.destroy

        flash[:notice] = "Item deleted successfully"
      else
        flash[:alert] = "Something went wrong!"
      end 
      redirect_back fallback_location: items_path

    
    end

    def search
        if params[:item].present?
            
            @item = Item.where(name: params[:item])
            if !@item.empty?
              respond_to do |format|
                format.js {render partial: 'items/items-result'} 
              end
            else
              respond_to do |format|
                flash.now[:alert] = "No item found"
                format.js {render partial: 'items/items-result'}
              end
              # flash[:notice] = 'Please enter a valid name'  
              # redirect_to request.referrer
            end

        else
          respond_to do |format|
            flash.now[:alert] = "Enter somthing to search"
            format.js {render partial: 'items/items-result'}
          end
        end

    
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
      @item = Item.find(params[:id]) rescue not_found
      if @item.present?
        if current_user.admin != true
          flash[:notice] = "This action is forbidden for you!"
          redirect_to root_path
        end
      else
        flash[:notice] = "Item not found!"
        redirect_to items_path
      end
  end

  def not_found
    flash[:alert] = "Something is missing!"
    redirect_to root_path
  end


end