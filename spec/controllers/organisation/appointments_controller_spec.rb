require 'rails_helper'

RSpec.describe Organisation::AppointmentsController, type: :controller do
  let(:user) { FactoryGirl.create(:organisation) }

  context 'logged in as organisation' do
    before { sign_in(:organisation, user) }

    describe '#index' do
      subject { get :index }

      it { is_expected.to render_template(:index) }
    end

    describe '#new' do
      subject { get :new }

      it { is_expected.to render_template(:new) }
    end

    describe '#create' do
      subject { post :create, appointment: params_for_create }

      context 'with valid params' do
        let(:params_for_create) { FactoryGirl.attributes_for(:appointment, organisation: user).merge(address_attributes: FactoryGirl.attributes_for(:address)) }

        it { is_expected.to redirect_to(organisation_appointments_path) }

        it 'set flash notification' do
          subject
          expect(flash[:notice]).to eq(I18n.t('notification.save.success', model: Appointment.model_name.human))
        end

        it 'creates appointment' do
          expect{ subject }.to change{ Appointment.count }.by(1)
        end
      end

      context 'with invalid params' do
        let(:params_for_create) { FactoryGirl.attributes_for(:appointment, organisation: user, name: '') }

        it { is_expected.to render_template(:new) }

        it 'set flash error' do
          subject
          expect(flash.now[:alert]).to eq(I18n.t('notification.save.fail', model: Appointment.model_name.human))
        end

        it 'does not create appointment' do
          expect{ subject }.to_not change{ Appointment.count }
        end
      end
    end

    describe '#show' do
      let(:appointment) { FactoryGirl.create(:appointment, organisation: user) }
      subject { get :show, id: appointment.id }

      it { is_expected.to render_template(:show) }
    end

    describe '#edit' do
      let(:appointment) { FactoryGirl.create(:appointment, organisation: user) }
      subject { get :edit, id: appointment.id }

      it { is_expected.to render_template(:edit) }
    end

    describe '#update' do
      let(:appointment) { FactoryGirl.create(:appointment, organisation: user) }
      subject { patch :update, id: appointment.id, appointment: params_for_update }

      context 'with valid params' do
        let(:params_for_update) { {title: 'a new title'} }

        it { is_expected.to redirect_to(organisation_appointments_path) }

        it 'sets the flash notification' do
          subject
          expect(flash[:notice]).to eq(I18n.t('notification.save.success', model: Appointment.model_name.human))
        end

        it 'updates the appointment' do
          expect { subject }.to change { appointment.reload.title }.to('a new title')
        end
      end

      context 'with invalid params' do
        let(:params_for_update) { {title: nil} }

        it { is_expected.to render_template(:edit) }

        it 'sets the flash error' do
          subject
          expect(flash.now[:alert]).to eq(I18n.t('notification.save.fail', model: Appointment.model_name.human))
        end

        it 'does not update the interpreter' do
          expect { subject }.to_not change { appointment.reload.title }
        end
      end
    end

    describe '#move_to_done' do
      subject { patch :move_to_done, id: appointment.id }

      context 'success' do
        let(:appointment) { FactoryGirl.create(:appointment, :assigned, organisation: user) }

        it { is_expected.to redirect_to(organisation_appointments_path) }

        it 'sets the flash notification' do
          subject
          expect(flash[:notice]).to eq(I18n.t('organisation.appointments.move_to_done.success'))
        end
      end

      context 'fail' do
        let(:appointment) { FactoryGirl.create(:appointment, :available, organisation: user) }

        it { is_expected.to redirect_to(organisation_appointments_path) }

        it 'sets the flash error' do
          subject
          expect(flash.now[:alert]).to eq(I18n.t('organisation.appointments.move_to_done.fail'))
        end
      end
    end

    describe '#destroy' do
      let!(:appointment) { FactoryGirl.create(:appointment, organisation: user) }
      subject { delete :destroy, id: appointment.id }

      it { is_expected.to redirect_to(organisation_appointments_path) }

      context 'destroyable' do
        it 'is destroyed' do
          expect { subject }.to change { Appointment.count }.by(-1)
        end

        it 'sets the flash notification' do
          subject
          expect(flash[:notice]).to eq(I18n.t('notification.destroy.success', model: Appointment.model_name.human))
        end
      end

      context 'not destroyable' do
        let(:appointment) { FactoryGirl.create(:appointment, :assigned, organisation: user) }

        it 'sets the flash error' do
          subject
          expect(flash.now[:alert]).to eq(I18n.t('notification.destroy.fail', model: Appointment.model_name.human))
        end

        it 'gets not destroyed' do
          expect { subject }.to_not change { Appointment.count }
        end
      end
    end
  end
end
