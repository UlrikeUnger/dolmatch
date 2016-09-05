class Admin::OrganisationsController < Admin::BaseController
  before_action :organisation, only: :show

  def index
    @search = Organisation.ransack(params[:q])
    @search.sorts = 'date_at desc' if @search.sorts.empty?
    @organisations = @search.result.paginate(page: params[:page])
  end

  def show; end

  private

  def organisation
    @organisation ||= Organisation.find(params[:id])
  end
end
