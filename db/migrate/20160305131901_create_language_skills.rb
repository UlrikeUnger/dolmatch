class CreateLanguageSkills < ActiveRecord::Migration
  def change
    create_table :language_skills do |t|
      t.string :locale
      t.integer :level
      t.belongs_to :interpreter

      t.timestamps null: false
    end
  end
end
