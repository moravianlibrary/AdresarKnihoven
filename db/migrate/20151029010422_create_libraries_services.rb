class CreateLibrariesServices < ActiveRecord::Migration
  def change
    create_table :libraries_services, id: false do |t|
      t.references :library, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true
    end
  end
end
