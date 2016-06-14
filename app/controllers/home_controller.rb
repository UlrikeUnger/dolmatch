class HomeController < ApplicationController
  def index

    if current_organisation
      redirect_to organisation_appointments_path
    elsif current_interpreter
      @search = Appointment.with_status(:available).order(:date_at).ransack(params[:q])
      @appointments = @search.result.paginate(page: params[:page])
    else
      render layout: 'landing_page'
    end
  end
end
