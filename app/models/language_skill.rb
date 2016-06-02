# == Schema Information
#
# Table name: language_skills
#
#  id             :integer          not null, primary key
#  locale         :string
#  level          :integer
#  interpreter_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class LanguageSkill < ActiveRecord::Base
  LEVELS = %w[conversational intermediate profi business_fluent mother_tongue].freeze

  belongs_to :interpreter

  validates :level, :locale, presence: true

  enum levels: LEVELS
end
