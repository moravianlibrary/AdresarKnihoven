class RemovePhoneFromLibrary < ActiveRecord::Migration
  def change
    remove_column :libraries, :phone, :string
  end
end
