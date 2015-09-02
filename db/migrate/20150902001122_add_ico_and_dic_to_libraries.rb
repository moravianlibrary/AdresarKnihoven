class AddIcoAndDicToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :ico, :string
    add_column :libraries, :dic, :string
  end
end
