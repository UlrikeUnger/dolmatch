class CreateRefugee < ActiveRecord::Migration
  def change
    create_table :refugees do |t|
      t.string :name
      t.string :phone_number
      t.string :country_of_origin
    end
  end
end
