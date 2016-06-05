class Interpreter::AppointmentsController < ApplicationController
  before_action :appointment, only: :update
  before_action :general_appointment, only: [:assign, :show]

  def index
    @appointments = Appointment.with_status([:assigned, :done]).where(interpreter: current_interpreter)
  end

  def show
  end

  def update
    if @appointment.public_send(params[:event])
      flash[:success] = t("#{params[:event]}.save.success")
    else
      flash[:error] = t("#{params[:event]}.save.fail")
    end

    redirect_to interpreter_appointments_path
  end

  def assign
    @appointment.assign_attributes(interpreter: current_interpreter)

    if @appointment.assign
      flash[:success] = t('.success')
    else
      flash[:error] = t('.fail')
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
