class AddZipAndRadiusToInterpreter < ActiveRecord::Migration
  def change
    add_column :interpreters, :zip, :string
    add_column :interpreters, :radius, :string
  end
end
