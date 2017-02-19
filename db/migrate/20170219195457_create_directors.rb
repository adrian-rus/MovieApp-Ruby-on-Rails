class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :firstname
      t.string :lastname
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
