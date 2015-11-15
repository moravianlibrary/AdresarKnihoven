# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Project.destroy_all

Project.create!([
{
	code: "01", 
	name: "Česká digitální knihovna",
	description: "Hlavním cílem projektu je vytvoření České digitální knihovny, která bude agregátorem digitálních knihoven provozovaných v České republice. Bude nabízet jednotné rozhraní pro koncové uživatele a zároveň bude sloužit jako hlavní poskytovatel dat pro mezinárodní projekty, zejména pro projekt evropské digitální knihovny Europeana. Bude také významným zdrojem digitálních dat a jedním z hlavních pilířů potřebných pro zajištění centralizovaných služeb v rámci České republiky definovaných v Koncepci rozvoje knihoven ČR na léta 2011 – 2014.",
	url: "http://www.czechdigitallibrary.cz/"
},
{
	code: "02",
	name: "eBook on Demand",
	description: "E-knihy na objednávku"	
},
{
	code: "03", 
	name: "Europeana",
	description: "Europeana je internetový projekt souboru evropských digitálních knihoven s naskenovanými obrazy, knihami, filmy a archivy.",
	url: "http://www.europeana.eu/"
},
{
	code: "04", 
	name: "Knihovny.cz",
	description: "Centrální portál českých knihoven vám umožní získat požadované dokumenty v tradiční tištěné nebo digitální formě a pohotové a komplexní informace kdykoli, odkudkoli a kdekoli.",
	url: "http://www.knihovny.cz/"
},
{
	code: "05", 
	name: "Manuscriptorium",
	description: "Manuscriptorium je volně dostupná digitální knihovna, která pomocí propracovaných rešeršních nástrojů umožňuje snadný přístup k soustředěným informacím o historických fondech. Cílem projektu je zpřístupnit existující digitální obsah pomocí jednotných nástrojů tak, aby byl co nejlépe dostupný, a proto digitální knihovna agreguje dokumenty mnoha významných institucí nejen ze zemí Evropské Unie.",
	url: "http://www.manuscriptorium.com/cs"
},
{
	code: "06", 
	name: "Souborný katalog ČR",
	description: "Souborný elektronický katalog, který soustřeďuje ve své bázi údaje o dokumentech ve fondech spolupracujících českých knihoven a institucí. V současné době obsahuje více než 6 mil. záznamů českých a zahraničních monografií, speciálních dokumentů, seriálů (časopisy, sborníky, zprávy z konferencí apod.) a v samostatné databázi články.",
	url: "http://new.caslin.cz/"
},
{
	code: "07", 
	name: "Virtuální národní fonotéka",
	description: "Cílem projektu je umožnění přístupu k zajímavým nahrávkám z celého světa, k projektům spojeným s kulturním dědictvím zaznamenaným na zvukových nosičích a umožnění náhledu do světových knihoven a jejich fonoték.",
	url: "https://www.narodnifonoteka.cz/"
},
{
	code: "08", 
	name: "Virtuální polytechnická knihovna",
	description: "Virtuální polytechnická knihovna nabízí službu dodávání dokumentů. Uživatel si objednává dokumenty a články z časopisů (v elektronické nebo tištěné podobě) nebo službu current contents (zasílání obsahů časopisů).",
	url: "https://www.techlib.cz/cs/2892-virtualni-polytechnicka-knihovna"
},
{
	code: "09", 
	name: "Portál Historické fondy",
	description: "V roce 2013 bylo zahájeno jednání s Národní knihovnou, Knihovnou Národního muzea, Knihovnou Akademie věd ČR a Vědeckou knihovnou v Olomouci o vytvoření společného sdruženého katalogu historických fondů. V první řadě by prostřednictvím tohoto katalogu měly být zpřístupněny staré tisky zmíněných institucí.",
	url: "https://www.historickefondy.cz/"
},
{
	code: "10", 
	name: "Databáze národních autorit NK ČR",
	description: "Portál Národní autority ČR soustředí na jednom místě zatím mnohdy roztříštěné informace o problematice (v nejširším slova smyslu) tvorby a využívání souborů národních autorit všech typů.",
	url: "http://aleph.nkp.cz/F/?func=file&file_name=find-a&local_base=aut"
},
{
	code: "11", 
	name: "Jednotná informační brána",
	description: "Portál Jednotné informační brány umožňuje uživatelům z jednoho místa jedním vyhledávacím rozhraním využívat různé české a zahraniční zdroje (katalogy knihoven, souborné katalogy, plnotextové databáze, atd). Portál zahrnuje všeobecné i oborové zdroje, vítáme jakékoliv návrhy na další vhodné zdroje k zapojení.",
	url: "http://www.jib.cz/"
},
{
	code: "12", 
	name: "ObálkyKnih.cz",
	description: "Služba obalkyknih.cz vznikla v roce 2008 díky projektu Moravské zemské knihovny v rámci programu VISK3. Jejím původním cílem bylo stát se centrálním repozitářem obrázků obálek knih určených pro integraci do katalogů knihoven. V dalších letech projekt prošel intenzivním vývojem, který umožnil rozšíření služeb poskytování nejen obálek knih, ale také dalších prvků (obsahy knih, anotace, ...).",
	url: "http://obalkyknih.cz/"
}
])
