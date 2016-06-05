class HomeController < ApplicationController
  def index
    if current_organisation
      redirect_to organisation_appointments_path
    else
      @search = Appointment.with_status(:available).order(:date_at).ransack(params[:q])
      @appointments = @search.result.paginate(page: params[:page])
    end
  end
end
