class CreateOrganisation < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.integer :address_id

      t.timestamps
    end
  end
end
