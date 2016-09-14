require 'rails_helper'

RSpec.describe Interpreter::AppointmentsController, type: :controller do

  let(:user) { FactoryGirl.create(:interpreter) }

  context 'logged in as interpreter' do
    before { sign_in(:interpreter, user) }

    describe '#index' do
      subject { get :index }

      it { is_expected.to render_template(:index) }
    end

    describe '#search' do
      subject { get :search }

      it { is_expected.to render_template(:search) }
    end

    describe '#show' do
      let(:appointment) { FactoryGirl.create(:appointment) }
      subject { get :show, id: appointment.id }

      it { is_expected.to render_template(:show) }
    end

    describe '#update' do
      it 'needs to be merged assign and update if possible'
      #move assign into update
    end
  end

  context 'not logged it as interpreter' do
    describe '#index' do
      subject { get :index }

      it { is_expected.to redirect_to(search_interpreter_appointments_path) }
    end
  end
end
