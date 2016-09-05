class Admin::InterpretersController < Admin::BaseController
  before_action :interpreter, only: :show

  def index
    @search = Interpreter.ransack(params[:q])
    @search.sorts = 'date_at desc' if @search.sorts.empty?
    @interpreters = @search.result.paginate(page: params[:page])
  end

  def show; end

  private

  def interpreter
    @interpreter ||= Interpreter.find(params[:id])
  end
end
