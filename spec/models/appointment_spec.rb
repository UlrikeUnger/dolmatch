require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { is_expected.to validate_presence_of(:venue) }
  it { is_expected.to validate_presence_of(:organisation) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:date_at) }
  it { is_expected.to validate_presence_of(:start_time_at) }
  it { is_expected.to validate_presence_of(:language_from) }
  it { is_expected.to validate_presence_of(:language_to) }
  it { is_expected.to validate_presence_of(:kind) }

  it { is_expected.to belong_to(:organisation) }
  it { is_expected.to belong_to(:interpreter) }
  it { is_expected.to belong_to(:refugee) }
  it { is_expected.to belong_to(:address) }

  describe 'state machine' do
    let(:appointment) { FactoryGirl.create(:appointment, state) }

    context 'when created' do
      let(:state) { :created }

      it 'has correct events' do
        expect(appointment.state_events).to match_array([:confirm_organisation])
      end
    end

    context 'when available' do
      let(:state) { :available }

      it 'has correct events' do
        expect(appointment.state_events).to match_array([:assign])
      end
    end

    context 'when assigned' do
      let(:state) { :assigned }

      it 'has correct events' do
        expect(appointment.state_events).to match_array([:unassign, :move_to_done])
      end
    end
  end
end
