class ApplicationController < ActionController::Base


    rescue_from ActionView::MissingTemplate, :with => :template_not_found

    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    after_action :check_role

    helper_method :get_item_name, :get_item_picture, :get_item_price, :get_user_name, :get_item, :already_liked?, :get_likes_count, :get_added_by, :get_user_full_name, :get_user_orders, :get_user_likes

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_picture])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :profile_picture, :first_name, :last_name, :password])
    end

    def require_admin
        if current_user.admin == false 
            flash[:notice] = 'This action is forbidden for you!'
            redirect_to items_path
        end
    end


    def check_role
        if signed_in?
            if current_user.admin == true
                
            else
                
            end
        end
    end


    #  HELPER


    def already_liked?(item, user)
        like = Like.where(item_id: item.id, user_id: user.id)
        if like.empty?
            return false
        else
            return true
        end
    end

    

    def get_item(item_id)
        @item = Item.find(item_id)
        return @item
    end
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

    def get_likes_count(item_id)
        likes = Like.where(item_id: item_id)
        return likes.count
    end

    def get_added_by(item_id)
        @item = Item.find(item_id)
        @adder = User.where(id: @item.user_id).first
        return "#{@adder.first_name} #{@adder.last_name}"
    end

    def get_user_full_name(id)
        @user = User.find(id)
        return "#{@user.first_name} #{@user.last_name}"
    end
    
    def get_user_orders(id)
        @orders = Order.where(user_id: id)
        return @orders.length
    end
    
    def get_user_likes(id)
        @likes = Like.where(user_id: id)
        return @likes.length
    end
    


    private
  
    def template_not_found
      redirect_to root_path
    end
end
