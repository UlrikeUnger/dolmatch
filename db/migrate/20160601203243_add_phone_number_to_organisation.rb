class AddPhoneNumberToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :phone_number, :string
  end
end
