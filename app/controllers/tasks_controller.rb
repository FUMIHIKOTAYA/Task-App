class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)

  def index
    if params[:title].blank? && params[:status] == ''
      redirect_to tasks_path, notice: t('view.flash.search')
    elsif params[:sort_expired]
      @tasks = Task.all.sorted_deadline
    elsif params[:title].blank? && params[:status]
      @tasks = Task.search_status(params[:status]).sorted
    elsif params[:title] && params[:status].blank?
      @tasks = Task.search_title(params[:title]).sorted
    elsif params[:title] && params[:status]
      @tasks = Task.search_title(params[:title]).search_status(params[:status]).sorted
    else
      @tasks = Task.all.sorted
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.new(task_params)
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
    params.require(:task).permit(:title, :content, :deadline, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
