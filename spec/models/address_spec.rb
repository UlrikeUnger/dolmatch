require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to have_one(:organisation) }
  it { is_expected.to have_one(:appointment) }

  it { is_expected.to validate_presence_of(:zip) }
  it { is_expected.to validate_presence_of(:city) }
end
