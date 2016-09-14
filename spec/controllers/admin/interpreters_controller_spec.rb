require 'rails_helper'

RSpec.describe Admin::InterpretersController, type: :controller do

  let(:user) { FactoryGirl.create(:admin) }

  context 'logged in as admin' do
    before { sign_in(:admin, user) }

    describe '#index' do
      subject { get :index }

      before { FactoryGirl.create(:interpreter) }

      it { is_expected.to render_template(:index) }
    end

    describe '#show' do
      let(:interpreter) { FactoryGirl.create(:interpreter) }
      subject { get :show, id: interpreter.id }

      it { is_expected.to render_template(:show) }
    end
  end
end
