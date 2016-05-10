class Organisation < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments
  belongs_to :address

  accepts_nested_attributes_for :address, reject_if: :all_blank

  before_save :set_existing_appointments_available

  private

  def set_existing_appointments_available
    self.appointments.map(&:confirm_organisation) if self.confirmed_at_changed?
  end
end
