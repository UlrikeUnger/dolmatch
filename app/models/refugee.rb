# == Schema Information
#
# Table name: refugees
#
#  id                :integer          not null, primary key
#  name              :string
#  phone_number      :string
#  country_of_origin :string
#

class Refugee < ActiveRecord::Base
end
