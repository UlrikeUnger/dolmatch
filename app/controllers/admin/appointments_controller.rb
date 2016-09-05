class Admin::AppointmentsController < Admin::BaseController
  before_action :appointment, only: :show

  def index
    @search = Appointment.ransack(params[:q])
    @search.sorts = 'date_at desc' if @search.sorts.empty?
    @appointments = @search.result.paginate(page: params[:page])
  end

  def show; end

  private

  def appointment
    @appointment ||= Appointment.find(params[:id])
  end
end
