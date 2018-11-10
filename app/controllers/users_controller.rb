class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all
  end

  def show
    if logged_in?
      @user = User.find(params[:id])
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC')
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
