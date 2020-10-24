class LabelsController < ApplicationController
  def index
    @labels = Label.where(user_id: current_user.id)
    @labels_general = Label.where(user_id: nil) if current_user.admin == true
  end

  def  new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      redirect_to labels_path, notice: t('view.flash.label_save')
    else
      render :new
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: t('view.flash.label_delete')
  end

  private

  def label_params
    params.require(:label).permit(:label_name)
  end
end
