class CreateLibrariesProjects < ActiveRecord::Migration
  def change
    create_table :libraries_projects do |t|
      t.references :library, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
    end
  end
end
