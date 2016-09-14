require 'rails_helper'

RSpec.describe InterpretersController, type: :controller do
  let(:interpreter) { FactoryGirl.create(:interpreter) }

  before do
    sign_in(:interpreter, interpreter)
  end

  describe '#edit' do
    subject { get :edit, id: interpreter.id }

    it { is_expected.to render_template(:edit) }
  end

  describe '#update' do
    subject { patch :update, id: interpreter.id, interpreter: params_for_update }

    context 'with valid params' do
      let(:params_for_update) { {name: 'a new name'} }

      it { is_expected.to redirect_to(interpreter_appointments_path) }

      it 'sets the flash notification' do
        subject
        expect(flash[:notice]).to eq(I18n.t('notification.save.success', model: Interpreter.model_name.human))
      end

      it 'updates the interpreter' do
        expect { subject }.to change { interpreter.reload.name }.to('a new name')
      end
    end

    context 'with invalid params' do
      let(:params_for_update) { {name: nil} }

      it { is_expected.to render_template(:edit) }

      it 'sets the flash error' do
        subject
        expect(flash.now[:alert]).to eq(I18n.t('notification.save.fail', model: Interpreter.model_name.human))
      end

      it 'does not update the interpreter' do
        expect { subject }.to_not change { interpreter.reload.name }
      end
    end
  end
end
