class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = if user_params == {}
					User.new_guest
				else
					User.new(user_params)
				end
		# @user = User.new(user_params)
		# @user = user_params ? User.new(user_params) : User.new_guest
		if @user.save
			current_user.move_to(@user) if current_user && current_user.guest?
			session[:user_id] = @user.id
			redirect_to new_task_path, notice: "thanks for signing up"
		else
			render "new"
		end
	end

	def user_params
		# params.require(:user).permit(:email, :password, :password_confirmation)
		params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
	end

end
