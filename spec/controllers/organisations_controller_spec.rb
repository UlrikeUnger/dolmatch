require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do
  let(:organisation) { FactoryGirl.create(:organisation) }

  before do
    sign_in(:organisation, organisation)
  end

  describe '#edit' do
    subject { get :edit, id: organisation.id }

    it { is_expected.to render_template(:edit) }
  end

  describe '#update' do
    subject { patch :update, id: organisation.id, organisation: params_for_update }

    context 'with valid params' do
      let(:params_for_update) { {name: 'a new name'} }

      it { is_expected.to redirect_to(organisation_appointments_path) }

      it 'sets the flash notification' do
        subject
        expect(flash[:notice]).to eq(I18n.t('notification.save.success', model: Organisation.model_name.human))
      end

      it 'updates the organisation' do
        expect { subject }.to change { organisation.reload.name }.to('a new name')
      end
    end

    context 'with invalid params' do
      let(:params_for_update) { {name: nil} }

      it { is_expected.to render_template(:edit) }

      it 'sets the flash error' do
        subject
        expect(flash.now[:alert]).to eq(I18n.t('notification.save.fail', model: Organisation.model_name.human))
      end

      it 'does not update the organisation' do
        expect { subject }.to_not change { organisation.reload.name }
      end
    end
  end
 end
