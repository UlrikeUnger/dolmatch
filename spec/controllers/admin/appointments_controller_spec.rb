require 'rails_helper'

RSpec.describe Admin::AppointmentsController, type: :controller do

  let(:user) { FactoryGirl.create(:admin) }

  context 'logged in as admin' do
    before { sign_in(:admin, user) }

    describe '#index' do
      subject { get :index }

      before { FactoryGirl.create(:appointment) }

      it { is_expected.to render_template(:index) }
    end

    describe '#show' do
      let(:appointment) { FactoryGirl.create(:appointment) }
      subject { get :show, id: appointment.id }

      it { is_expected.to render_template(:show) }
    end
  end
end
