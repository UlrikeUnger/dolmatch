class StaticPagesController < ApplicationController

  def home
    if current_organisation
      redirect_to organisation_appointments_path
    elsif current_interpreter
      @search = Appointment.with_state(:available).ransack(params[:q])
      @search.sorts = 'date_at desc' if @search.sorts.empty?
      @appointments = @search.result.paginate(page: params[:page])
    else
      render layout: 'landing_page'
    end
  end

  def imprint
  end

  def contact
  end

  def terms_and_conditions
  end
end
