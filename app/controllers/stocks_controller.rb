class StocksController < ApplicationController

 def search
 	if params[:stock].present?
 	  @stock = Stock.new_lookup(params[:stock])
 	   if @stock
 	  	   respond_to do |format| 
            format.js{ render partial: 'user/result' }
		   # render 'user/my_portfolio'
		   end
	   else
	  	   respond_to do |format|
	  	   	 flash.now[:alert] = "Please enter valid symbol" 
             format.js{ render partial: 'user/result' }
	  	   end	
	    end   
	else    respond_to do |format|
	  	   	 flash.now[:alert] = "Please enter a symbol to search"
             format.js{ render partial: 'user/result' }
	  	   end	
    end	
 end

end	