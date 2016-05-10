class CreateInterpreters < ActiveRecord::Migration
  def change
    create_table :interpreters do |t|
      t.timestamps null: false
    end
  end
end
