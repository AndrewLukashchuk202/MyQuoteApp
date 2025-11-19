class CreateQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :quotes do |t|
      t.text :text, null: false
      t.date :publication_year, null: true
      t.boolean :is_public, default: true
      t.text :user_comment, null: true
      t.references :user, null: false, foreign_key: true
      t.references :author, null: true, foreign_key: true

      t.timestamps
    end
  end
end
