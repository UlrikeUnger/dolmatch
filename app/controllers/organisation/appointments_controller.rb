class Organisation::AppointmentsController < ApplicationController
  before_action :organisation, except: :index
  before_action :appointment, only: [:edit, :update, :destroy, :show, :move_to_done]

  def index
    redirect_to root_path unless current_organisation
    @search = current_organisation.appointments.ransack(params[:q])
    @search.sorts = 'date_at desc' if @search.sorts.empty?
    @appointments = @search.result
  end

  def new
    @appointment = Appointment.new
    @appointment.build_address unless @appointment.address
    @appointment.build_refugee unless @appointment.refugee
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(organisation: @organisation))

    if @appointment.save
      flash[:notice] = t('notification.save.success', model: Appointment.model_name.human)
      redirect_to organisation_appointments_path
    else
      flash.now[:alert] = t('notification.save.fail', model: Appointment.model_name.human)
      @appointment.build_address unless @appointment.address
      @appointment.build_refugee unless @appointment.refugee
      render :new
    end
  end

  def edit
    @appointment.build_address unless @appointment.address
  end

  def show
  end

  def move_to_done
    if @appointment.move_to_done
      flash[:notice] = t('.success')
    else
      flash.now[:alert] = t('.fail')
    end

    redirect_to organisation_appointments_path
  end

  def update
    if @appointment.update(appointment_params)
      flash[:notice] = t('notification.save.success', model: Appointment.model_name.human)
      redirect_to organisation_appointments_path
    else
      @appointment.build_address unless @appointment.address
      flash.now[:alert] = t('notification.save.fail', model: Appointment.model_name.human)
      render :edit
    end
  end

  def destroy
    if @appointment.available? && @appointment.destroy
      flash[:notice] = t('notification.destroy.success', model: Appointment.model_name.human)
    else
      flash.now[:alert] = t('notification.destroy.fail', model: Appointment.model_name.human)
    end
    redirect_to organisation_appointments_path
  end

  private

  def organisation
    @organisation ||= current_organisation
  end

  def appointment
    @appointment ||= current_organisation.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_time_at, :end_time_at, :date_at, :kind, :description,
    :venue, :language_to, :language_from, :title,
    address_attributes: [:id, :street, :zip, :city, :house_number],
    refugee_attributes: [:name, :phone_number, :country_of_origin])
  end
end
