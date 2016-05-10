class OrganisationsController < ApplicationController
  before_action :organisation

  def edit
    @organisation.build_address unless @organisation.address
  end

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

  def organisation
    @organisation ||= current_organisation
  end

  def organisation_params
    params.require(:organisation).permit(:name,
    address_attributes: [:id, :street, :zip, :city, :house_number])
  end
end
