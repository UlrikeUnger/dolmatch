class AddTitleToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :title, :string
  end
end
