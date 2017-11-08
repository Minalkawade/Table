class SessionsController < ApplicationController
	def new
		
	end

	def create
		user=User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			 
			if user.email_confirmed
				session[:user_id]= user.id 

				flash[:success]="You have successfully logged in!!!"
				redirect_to user_path(user)
			else
				flash[:danger]="Activate your account!!!"
			end

		else
			flash.now[:danger]="Login Failed!!!!"
			render 'new'

		end
	 end

	
	def destroy
		session[:user_id]=nil
		flash[:success]="You have loggd out"
		redirect_to root_path

	end

	def show

	end

end