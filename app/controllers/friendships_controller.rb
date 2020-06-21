class FriendshipsController < ApplicationController

	def create
       friend = User.find_by_first_name(params[:friend])
        if friend.present? 
		   @friendship = Friendship.create(user: current_user, friend: friend)
		   flash[:notice] = "Successfully started following"
		end
	   redirect_to my_friends_path
	end	

	def destroy
      friend = User.find(params[:id])
      friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
	  friendship.destroy
	  flash[:alert] = "Unfollowed successfully "
	  redirect_to my_friends_path
	end	
end
