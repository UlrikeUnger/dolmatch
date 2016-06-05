class LanguagesController < ApplicationController
  def update
    session[:locale] = params.require(:language).permit(:locale)[:locale].to_sym
    redirect_to request.referer
  end
end
