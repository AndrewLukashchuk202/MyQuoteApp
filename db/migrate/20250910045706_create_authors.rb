class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string :fname, null: true
      t.string :lname, null: true
      t.text :biography, null: true
      t.date :birth_year, null: true
      t.date :death_year, null: true

      t.timestamps
    end
  end
end
