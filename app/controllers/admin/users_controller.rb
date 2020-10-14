class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :check_administrator
  before_action :user_login

  def index
    @users = User.select(:id, :name, :email, :admin, :created_at, :updated_at).order(created_at: :DESC).page(params[:page]).per(8)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('view.flash.admin_user_new')
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.order(created_at: :DESC)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('view.flash.admin_user_update')
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
     redirect_to admin_users_path, notice: t('view.flash.admin_user_delete')
   else
     redirect_to admin_users_path, alert: t('view.flash.user_undeletable')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_administrator
    redirect_to tasks_path, alert: t('view.flash.check_administrator') unless current_user.try(:admin?)
  end

  def user_login
      redirect_to new_session_path, notice: t('view.flash.authenticate_user') if current_user.nil?
  end
end
