class StaticPagesController < ApplicationController

  def home
    if current_admin
      redirect_to admin_appointments_path
    elsif current_organisation
      redirect_to organisation_appointments_path
    elsif current_interpreter
      redirect_to search_interpreter_appointments_path      
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
