require 'rails_helper'

RSpec.describe Organisation, type: :model do
  it { is_expected.to have_many(:appointments) }
  it { is_expected.to belong_to(:address) }

  it { is_expected.to accept_nested_attributes_for(:address) }

  it { is_expected.to validate_presence_of(:name) }
end
