class AddDateAndPlaceToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date, :date
    add_column :events, :place, :string
  	add_index :events, :date
  end

end
