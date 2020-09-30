class UsersController < ApplicationController
  before_action :logged_user, only: %i(new)
  before_action :another_account, only: %i(show)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show; end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_user
    if logged_in?
      redirect_to user_path(current_user.id), notice: %q(ログイン済みです。)
    end
  end

  def another_account
    @user = User.find(params[:id])
    unless params[:id].to_i == current_user.id
      redirect_to tasks_path, notice: %q(実行権限がありません。)
    end
  end
end
