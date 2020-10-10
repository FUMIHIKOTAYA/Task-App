class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update)
  before_action :limit_access, only: %i(show edit update)
  before_action :logged_user, only: %i(new)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: t('view.flash.user_update')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def limit_access
    @user = User.find_by(id: params[:id])
    redirect_to tasks_path, notice: t('view.flash.limit_access') if @user.id != current_user.id && current_user.admin == false
  end

  def logged_user
    if logged_in?
      redirect_to user_path(current_user.id), notice: t('view.flash.logged_user')
    end
  end
end
