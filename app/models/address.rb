class Address < ActiveRecord::Base
  has_one :appointment
  has_one :organisation
end
