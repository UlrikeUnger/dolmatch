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

    context 'assign and unassign' do
      shared_examples 'update appointment' do |event, expected_state|

        it { is_expected.to redirect_to(interpreter_appointments_path) }

        context 'when allowed' do
          it 'sets the flash notice' do
            subject
            expect(flash[:notice]).to eq(I18n.t("interpreter.appointments.#{request.params[:action]}.success"))
          end

          it 'changes state of appointment' do
            expect{ subject }.to change{ appointment.reload.state }.to(expected_state)
          end
        end

        context 'when not allowed' do
          let(:appointment) { FactoryGirl.create(:appointment, :done, interpreter: user) }

          it 'sets the flash error' do
            subject
            expect(flash[:alert]).to eq(I18n.t("interpreter.appointments.#{request.params[:action]}.fail"))
          end

          it 'does not change state of apppointment' do
            expect { subject }.to_not change { appointment.reload.state }
          end
        end
      end

      describe '#update' do
        let!(:appointment) { FactoryGirl.create(:appointment, :assigned, interpreter: user) }

        subject { patch :update, event: :unassign, id: appointment.id  }

        it_behaves_like 'update appointment', :unassign, 'available'

        it 'removes the interpreter from the appointment' do
          expect{ subject }.to change{ appointment.reload.interpreter }.to(nil)
        end
      end

      describe '#assign' do
        let!(:appointment) { FactoryGirl.create(:appointment, :available) }

        subject { patch :assign, id: appointment.id }

        it_behaves_like 'update appointment', :assign, 'assigned'

        it 'assigns the current_interpreter' do
          expect{ subject }.to change{ appointment.reload.interpreter }.to(user)
        end
      end
    end
  end

  context 'not logged it as interpreter' do
    describe '#index' do
      subject { get :index }

      it { is_expected.to redirect_to(search_interpreter_appointments_path) }
    end
  end
end
