class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  before_action :limit_access, only: %i(edit update destroy)
  before_action :authenticate_user, only: %i(index)

  def index
    if params[:title].blank? && params[:status] == ''
      redirect_to tasks_path, notice: t('view.flash.search')
    elsif params[:sort_expired]
      @tasks = current_user.tasks.page(params[:page]).per(8).sorted_deadline
    elsif params[:sort_priority]
      @tasks = current_user.tasks.page(params[:page]).per(8).sorted_priority
    elsif params[:title].blank? && params[:status]
      @tasks = current_user.tasks.page(params[:page]).per(8).search_status(params[:status]).sorted
    elsif params[:title] && params[:status].blank?
      @tasks = current_user.tasks.page(params[:page]).per(8).search_title(params[:title]).sorted
    elsif params[:title] && params[:status]
      @tasks = current_user.tasks.page(params[:page]).per(8).search_title(params[:title]).search_status(params[:status]).sorted
    else
      @tasks = current_user.tasks.page(params[:page]).per(8).sorted
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: t('view.flash.save')
      else
        render :new
      end
    end
end

  def show
  end

  def edit
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('view.flash.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('view.flash.delete')
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def limit_access
    @task = Task.find_by(id: params[:id])
    unless @task.user_id == current_user.id
      redirect_to tasks_path, notice: t('view.flash.limit_access')
    end
  end

  def authenticate_user
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      flash[:notice] = t('view.flash.authenticate_user')
      redirect_to new_session_path
    end
  end
end
