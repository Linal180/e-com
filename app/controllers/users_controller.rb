class UsersController < ApplicationController


    def search_user
        if params[:user].present?
            @user = User.search(params[:user])
            @user = current_user.except_current_user(@user)
            if !@user.empty?
              respond_to do |format|
                format.js {render partial: 'pages/search/users-result'} 
              end
            else
              respond_to do |format|
                flash.now[:alert] = "No User found"
                format.js {render partial: 'pages/search/users-result'}
              end
              # flash[:notice] = 'Please enter a valid name'  
              # redirect_to request.referrer
            end

        else
          respond_to do |format|
            flash.now[:alert] = "Enter somthing to search"
            format.js {render partial: 'pages/search/users-result'}
          end
        end

    

    end


end 