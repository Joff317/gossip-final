class UsersController < ApplicationController

   def index 
      @users = User.all
   end
   
   def show 
      @user = User.get_user_id(params[:id])
   end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      
      # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
      @user.email.downcase!
      
      if @user.save
        # If user saves in the db successfully:
        flash[:notice] = "Account created successfully!"
        redirect_to '/login'
      else
        # If user fails model validation - probably a bad password or duplicate email:
        flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
        render :new
      end
    end
  
  private
  
    def user_params
      # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
      # that can be submitted by a form to the user model #=> require(:user)
      params.require(:user).permit(:first_name, :last_name, :email, :description, :city_id, :password, :password_confirmation)
    end
    

end
  