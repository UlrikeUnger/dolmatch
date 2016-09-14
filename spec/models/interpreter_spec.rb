require 'rails_helper'

RSpec.describe Interpreter, type: :model do
  it { is_expected.to have_many(:language_skills) }
  it { is_expected.to have_many(:appointments) }

  it { is_expected.to accept_nested_attributes_for(:language_skills) }
  it { is_expected.to validate_presence_of(:language_skills) }
  it { is_expected.to validate_presence_of(:name) }
end
