class UserController < ApplicationController
  
  def my_portfolio
  	@ticker = current_user.stocks
    @user = current_user
  end

  def my_friends
  	@friends = current_user.friends
  end
  
  def search_friends
    if params[:friend].present?
       @friends = User.search(params[:friend])
       @friends = current_user.except_self(@friends)
         if @friends
            respond_to do |format|
               format.js{render partial: 'user/friend_result'}
             end
         else
           respond_to do |format|
             flash.now[:alert] = "Not Found" 
             format.js{ render partial: 'user/friend_result' }
           end  
         end
    else
        respond_to do |format|
            flash.now[:alert] = "Please enter a name to search" 
            format.js{ render partial: 'user/friend_result' }
        end
    end
  end	

  def show
    @user = User.find(params[:id])
    @ticker = @user.stocks
    render 'user/view_profile' 
  end  

end
