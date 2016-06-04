class InterpretersController < ApplicationController
  before_action :interpreter

  def edit; end

  def update
    if @organisation.update(organisation_params)
      flash[:notice] = t('notification.save.success', model: Organisation.model_name.human)
      redirect_to organisation_appointments_path
    else
      @organisation.build_address unless @organisation.address
      flash.now[:alert] = t('notification.save.failure', model: Organisation.model_name.human)
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
