# == Schema Information
#
# Table name: organisations
#
#  id                     :integer          not null, primary key
#  name                   :string
#  address_id             :integer
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#

class Organisation < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments
  belongs_to :address

  accepts_nested_attributes_for :address, reject_if: :all_blank

  before_save :set_existing_appointments_available

  validates :name, presence: true

  private

  def set_existing_appointments_available
    self.appointments.map(&:confirm_organisation) if self.confirmed_at_changed?
  end
end
