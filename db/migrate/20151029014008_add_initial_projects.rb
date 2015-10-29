class AddInitialProjects < ActiveRecord::Migration
  def change
  	Project.create(code: "01", name: "Česká digitální knihovna")
	Project.create(code: "02", name: "eBook on Demand")
	Project.create(code: "03", name: "Europeana")
	Project.create(code: "04", name: "Knihovny.cz")
	Project.create(code: "05", name: "Manuscriptorium")
	Project.create(code: "06", name: "Souborný katalog ČR") 
	Project.create(code: "07", name: "Virtuální národní fonotéka")
	Project.create(code: "08", name: "Virtuální polytechnická knihovna")
	Project.create(code: "09", name: "Portál Historické fondy")
	Project.create(code: "10", name: "Databáze národních autorit NK ČR")
	Project.create(code: "11", name: "Jednotná informační brána")
	Project.create(code: "12", name: "ObálkyKnih.cz")
  end
end
