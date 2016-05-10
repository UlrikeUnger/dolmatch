class Appointment < ActiveRecord::Base
  KINDS = %i[doctor goverment_agency others].freeze
  STATUSES = %i[available assigned done].freeze

  belongs_to :organisation
  belongs_to :interpreter
  belongs_to :refugee
  belongs_to :address

  accepts_nested_attributes_for :address, reject_if: :all_blank

  validates :venue, :kind, :organisation, :language_from, :language_to, presence: true

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
