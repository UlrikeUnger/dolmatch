class Interpreter::AppointmentsController < ApplicationController
  before_action :appointment, only: :update
  before_action :general_appointment, only: [:assign, :show]

  def index
    if current_interpreter
      @appointments = Appointment.with_state([:assigned, :done]).where(interpreter: current_interpreter).order(date_at: :desc)
    else
      redirect_to search_interpreter_appointments_path
    end
  end

  def search
    @search = Appointment.with_state(:available).order(:date_at).ransack(params[:q])
    @appointments = @search.result.paginate(page: params[:page])
  end

  def show
  end

  def update
    if @appointment.public_send(params[:event])
      flash[:notice] = t('.success')
    else
      flash.now[:alert] = t('.fail')
    end

    redirect_to interpreter_appointments_path
  end

  def assign
    @appointment.assign_attributes(interpreter: current_interpreter)

    if @appointment.assign
      flash[:notice] = t('.success')
    else
      flash.now[:alert] = t('.fail')
    end

    redirect_to interpreter_appointments_path
  end

  private

  def general_appointment
    @appointment ||= Appointment.find(params[:id])
  end

  def appointment
    @appointment ||= current_interpreter.appointments.find(params[:id])
  end
end
