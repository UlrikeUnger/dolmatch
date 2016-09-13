class RenameStatusToState < ActiveRecord::Migration
  def change
    rename_column :appointments, :status, :state
  end
end
