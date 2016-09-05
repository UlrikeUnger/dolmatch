class HomeController < ApplicationController
  def index
    if current_admin
      redirect_to admin_appointments_path
    elsif current_organisation
      redirect_to organisation_appointments_path
    elsif current_interpreter
      @search = Appointment.with_status(:available).ransack(params[:q])
      @search.sorts = 'date_at desc' if @search.sorts.empty?
      @appointments = @search.result.paginate(page: params[:page])
    else
      render layout: 'landing_page'
    end
  end
end
