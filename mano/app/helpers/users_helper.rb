module UsersHelper

	def user_params
	  params.require(:user).permit(:first_name, :last_name, :email, :password)
	end

end