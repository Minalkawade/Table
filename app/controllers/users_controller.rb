class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only:[:edit, :update, :destroy]
  # GET /users
  # GET /users.json
  # devise :database_authenticatable, :registerable, :omniauthable, :confirmable,
  #        :recoverable, :rememberable, :trackable, :validatable
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      
      if @user.save
        @user.confirm_token
        @user.save(validate: false)
        UsermailerMailer.welcome_email(@user).deliver
       token_no = SecureRandom.urlsafe_base64
        session[:user_id]=@user.id
        flash[:success]="Welcome to alpha blog #{@user.username}!!"
        redirect_to users_path(@user)
      else
        render 'new'  
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      if @user.update(user_params)
       flash[:success]="User updated successfully!!"
       redirect_to users_path(@user) 
      else
        render 'edit'
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    @user.destroy
    flash[:danger]="User deleted successfully!!" 
    redirect_to users_path(@user)
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])
    if user
     user.validate_email
     user.save(validate: false)
     redirect_to user
   else
     flash[:error] = "Sorry. User does not exist"
     redirect_to root_url
   end
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :image, :document, :email_confirmed)

    end
      def require_same_user
    if current_user != @user

      flash[:danger]= "You can only edit or delete your own account!!"
      redirect_to root_path
    end
  end
end
