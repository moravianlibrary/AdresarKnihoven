class AddAdditionalNamesToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :bname, :string
    add_column :libraries, :cname, :string
    add_column :libraries, :bname_en, :string
    add_column :libraries, :cname_en, :string
  end
end
