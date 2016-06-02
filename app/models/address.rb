# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  street       :string
#  house_number :string
#  zip          :string
#  city         :string
#  created_at   :datetime
#  updated_at   :datetime
#

class Address < ActiveRecord::Base
  has_one :appointment
  has_one :organisation

  validates :zip, :city, presence: true
end
