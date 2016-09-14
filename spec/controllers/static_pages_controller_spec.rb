require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    subject { get :home }

    context 'not logged in' do
      it { is_expected.to render_template(:home) }

      it { is_expected.to render_with_layout :landing_page }
    end

    context 'logged in' do
      before { sign_in type, user }

      context 'as admin' do
        let(:user) { FactoryGirl.create(:admin) }
        let(:type) { :admin }

        it { is_expected.to redirect_to(admin_appointments_path) }
      end

      context 'as organisation' do
        let(:user) { FactoryGirl.create(:organisation) }
        let(:type) { :organisation }

        it { is_expected.to redirect_to(organisation_appointments_path) }
      end

      context 'as interpreter' do
        let(:user) { FactoryGirl.create(:interpreter) }
        let(:type) { :interpreter }

        it { is_expected.to render_template(:home) }
      end
    end
  end

  %w(imprint contact terms_and_conditions).each do |action|
    describe "##{action}" do
      subject { get action }

      it { is_expected.to render_template(action) }
    end
  end

end
