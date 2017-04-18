class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]) #ユーザ一覧
  end

  def show
    @user = User.find(params[:id]) #ユーザ詳細
  end

  def new
    @user = User.new #ユーザ登録
  end

  def create
    @user = User.new(user_params) #直接入れずにStrong Parameter使用
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
