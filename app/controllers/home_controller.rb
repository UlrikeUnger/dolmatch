class HomeController < ApplicationController
  def index
    @search = Appointment.with_status(:available).ransack(params[:q])
    @appointments = @search.result.paginate(page: params[:page])
  end
end
