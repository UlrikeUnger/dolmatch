class Organisation::AppointmentsController < ApplicationController
  before_action :organisation, except: :index
  before_action :appointment, only: [:edit, :update, :destroy, :show]

  def index
    @search = current_organisation ? current_organisation.appointments.ransack(params[:search]) : Appointment.ransack(params[:search])
    @appointments = @search.result.paginate(page: params[:page])
  end

  def new
    @appointment = Appointment.new
    @appointment.build_address unless @appointment.address
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(organisation: @organisation))

    if @appointment.save
      redirect_to organisation_appointments_path(@appointment)
    else
      @appointment.build_address unless @appointment.address
      render :new
    end
  end

  def edit
    @appointment.build_address unless @appointment.address
  end

  def show
  end

  def update
    if @appointment.update(appointment_params)
      flash[:notice] = t('notification.save.success', model: Appointment.model_name.human)
      redirect_to organisation_appointments_path
    else
      @appointment.build_address unless @appointment.address
      flash.now[:alert] = t('notification.save.failure', model: Appointment.model_name.human)
      render :edit
    end
  end

  def destroy
    if @appointment.destroy
      flash[:notice] = t('notification.destroy.success', model: Appointment.model_name.human)
    else
      flash.now[:alert] = t('notification.destroy.failure', model: Appointment.model_name.human)
    end
    redirect_to organisation_appointments_path
  end

  private

  def organisation
    @organisation ||= current_organisation
  end

  def appointment
    @appointment ||= Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :date_at, :kind, :description,
    :venue, :language_to, :language_from,
    address_attributes: [:id, :street, :zip, :city, :house_number])
  end
end
