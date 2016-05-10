class LanguageSkill < ActiveRecord::Base
  LEVELS = %w[conversational intermediate profi].freeze

  belongs_to :interpreter

  validates :level, :locale, presence: true

  enum levels: LEVELS
end
