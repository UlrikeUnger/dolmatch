class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :house_number
      t.string :zip
      t.string :city

      t.timestamps
    end
  end
end
