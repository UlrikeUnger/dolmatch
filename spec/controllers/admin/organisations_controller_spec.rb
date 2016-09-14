require 'rails_helper'

RSpec.describe Admin::OrganisationsController, type: :controller do

  let(:user) { FactoryGirl.create(:admin) }

  context 'logged in as admin' do
    before { sign_in(:admin, user) }

    describe '#index' do
      subject { get :index }

      before { FactoryGirl.create(:organisation) }

      it { is_expected.to render_template(:index) }
    end

    describe '#show' do
      let(:organisation) { FactoryGirl.create(:organisation) }
      subject { get :show, id: organisation.id }

      it { is_expected.to render_template(:show) }
    end
  end
end
