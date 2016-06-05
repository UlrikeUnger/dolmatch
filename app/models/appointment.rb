# == Schema Information
#
# Table name: appointments
#
#  id              :integer          not null, primary key
#  start_time_at   :time
#  end_time_at     :time
#  date_at         :date
#  kind            :integer
#  description     :text
#  venue           :string
#  status          :string
#  language_from   :string
#  language_to     :string
#  organisation_id :integer
#  interpreter_id  :integer
#  refugee_id      :integer
#  address_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Appointment < ActiveRecord::Base
  KINDS = %i[job_center agency education housing doctor police law_issues others].freeze
  STATUSES = %i[available assigned done].freeze

  belongs_to :organisation
  belongs_to :interpreter
  belongs_to :refugee
  belongs_to :address

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :refugee, reject_if: :all_blank

  validates :venue, :kind, :organisation, :address, :date_at,
  :language_from, :start_time_at, :language_to, presence: true

  scope :accessable, -> (current_interpreter) { where("status = 'available' OR interpreter_id = ?", current_interpreter) }

  enum kind: KINDS

  after_create :organisation_confirmed?

  state_machine :status, initial: :created do

    event :confirm_organisation do
      transition created: :available
    end

    event :assign do
      transition available: :assigned
    end

    event :unassign do
      transition assigned: :available
    end

    event :move_to_done do
      transition assigned: :done
    end

    state :assigned, :done do
      validates :interpreter, presence: true
    end

    state :assigned, :done, :unassign do
      validates :organisation, presence: true
    end
  end

  private

  def organisation_confirmed?
    confirm_organisation if organisation.confirmed?
  end

end
