class PagesController < ApplicationController

    skip_before_action :authenticate_user!, only: [:welcome]
    before_action :require_admin, only: [:admin, :all_items, :all_users, :make_admin, :delete_user]


    def dashboard
        if signed_in? && current_user.admin == true
            redirect_to admin_path
        else
            redirect_to welcome_path
        end
    end

    def welcome
    end

    def admin
    end

    def show
    end

    def all_users
        @all_users = User.where.not(id: current_user.id, admin: true)
        @admins = User.where(admin: true)
    end

    def all_items
        @all_items = Item.all
    end

    def make_admin
        @user = User.find(params[:id])
        
        @user.admin = true
        if @user && @user.save
            flash[:notice] = "#{get_user_full_name(@user.id)} has been made admin successfully"
            redirect_back fallback_location: items_path
        else
            flash[:alert] = "Something went wrong!"
            redirect_back fallback_location: items_path
        end 
    end

    def undo_admin
        @user = User.find(params[:id])
        
        @user.admin = false
        if @user && @user.save
            flash[:notice] = "#{get_user_full_name(@user.id)} has been removed from ADMINS successfully"
            redirect_back fallback_location: items_path
        else
            flash[:alert] = "Something went wrong!"
            redirect_back fallback_location: items_path
        end 
    end

    def all_orders
        @orders = Order.all
    end

    def delete_user
        @user = User.find(params[:id])
       
    end

end