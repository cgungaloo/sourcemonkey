class UsersController < ApplicationController
 def new
 end

 def create
 	@user =User.new(user_params)
 	if @user.save
 		puts "Hello!!!!!!!!!"
 		puts"Logged in as "+@user
 		flash[:notice] ="Welcome to Source Monkey!"
 		redirect_to "/"
 	else
 		flash[:alert] ="There was a problem creating your account. Please try again."
 		puts "Fail!!!!!!!!!"
 		redirect_to :back
 	end
 end

 private
 def user_params
 	params.require(:user).permit(:email,:password,:password_confirmation)
 end
end
