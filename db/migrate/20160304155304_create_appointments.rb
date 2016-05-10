class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.time :start_time_at
      t.time :end_time_at
      t.date :date_at
      t.integer :kind
      t.text :description
      t.string :venue
      t.string :status
      t.string :language_from
      t.string :language_to
      t.integer :organisation_id
      t.integer :interpreter_id
      t.integer :refugee_id
      t.integer :address_id

      t.timestamps null: false
    end
  end
end
