class AddPhoneToInterpreter < ActiveRecord::Migration
  def change
    add_column :interpreters, :name, :string
    add_column :interpreters, :phone_number, :string
  end
end
