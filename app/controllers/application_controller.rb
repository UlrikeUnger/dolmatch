class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale_from_session
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_organisation
      organisation_appointments_path
    elsif current_admin
      admin_appointments_path
    else
      interpreter_appointments_path
    end
  end

  def set_locale_from_session
    I18n.locale = session[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, address_attributes: [:street, :zip, :city, :house_number],
      language_skills_attributes: [:id, :locale, :level])
    end
  end
end
