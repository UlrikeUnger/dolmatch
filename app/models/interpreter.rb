class Interpreter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :language_skills
  has_many :appointments

  accepts_nested_attributes_for :language_skills

  validates_associated :language_skills
  validates :language_skills, presence: true
end
