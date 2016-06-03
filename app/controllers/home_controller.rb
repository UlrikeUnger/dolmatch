class HomeController < ApplicationController
  def index
    render layout: 'landing_page'
  end
end
