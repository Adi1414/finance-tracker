class UserController < ApplicationController
  
  def my_portfolio
  	@ticker = current_user.stocks
  end

end
