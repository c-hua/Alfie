class UsersController < ApplicationController

  def index
      @users = User.all

  end

  def custom
    raise params.inspect
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
      @user = User.find(params[:id])
      @user.tally_points
         respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You have signed up successfully"
      redirect_to tasks_path
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
