class InterpretersController < ApplicationController
  before_action :interpreter

  def edit; end

  def update
    if @interpreter.update(interpreter_params)
      flash[:notice] = t('notification.save.success', model: Interpreter.model_name.human)
      redirect_to interpreter_appointments_path
    else
      flash.now[:alert] = t('notification.save.fail', model: Interpreter.model_name.human)
      render :edit
    end
  end

  private

  def interpreter
    @interpreter ||= current_interpreter
  end

  def interpreter_params
    params.require(:interpreter).permit(:name, :zip, :radius, language_skills_attributes: [:locale, :level])
  end
end
