class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :code
      t.string :city
      t.string :street
      t.string :zip
      t.string :description
      t.string :coordinates
      t.string :description
      t.string :email
      t.string :sigla
      t.string :district
      t.string :town
      t.string :url
      t.string :type
      t.string :phone

      t.timestamps null: false
    end
    add_index :libraries, :name
    add_index :libraries, :sigla
  end
end
