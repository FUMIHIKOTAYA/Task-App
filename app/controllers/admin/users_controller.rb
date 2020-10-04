class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :check_administrator

  def index
    @users = User.select(:id, :name, :email, :admin, :created_at).order(created_at: :DESC).page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.order(created_at: :DESC)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: %q(ユーザー情報を更新しました。)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: %q(ユーザーアカウントを削除しました。)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_administrator
    redirect_to tasks_path, alert: '管理者権限のあるユーザーアカウントでログインする必要があります。' unless current_user.admin?
  end
end