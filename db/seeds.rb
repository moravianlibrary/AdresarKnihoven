
# Default projects
Project.destroy_all

Project.create!([
{
	code: "01", 
	name: "Česká digitální knihovna",
	description: "Česká digitální knihovna je projektem Ministerstva kultury ČR a jeho hlavním cílem je vytvoření jednotné virtuální knihovny, která propojí již existující digitální knihovny provozované v České republice. Česká digitální knihovna vám nabídne přístup k digitálním dokumentům (informacím) z centrálního místa. Zároveň bude sloužit jako zdroj dat pro vývoj dalších služeb definovaných v Koncepci rozvoje knihoven České republiky na léta 2011 – 2015 i pro mezinárodní projekty digitálních knihoven, jako je například Europeana.",
	url: "http://www.czechdigitallibrary.cz/"
},
{
	code: "02",
	name: "eBook on Demand",
	description: "Službu eBooks on Demand (zkráceně EOD) nabízí již řada předních evropských knihoven včetně několika knihoven v České republice. Slouží k objednávání digitálních kopií historických knih z fondů knihoven. Do digitální podoby je možné převést knihy, které již nejsou chráněny autorským zákonem, tj. pokud již uplynulo 70 let od úmrtí jejich autora. Díky digitalizaci se tak historické knihy stávají snadno dostupné pro badatele z celého světa. V České republice jsou do služby EOD zapojeny Národní technická knihovna, Vědecká knihovna v Olomouci, Moravská zemská knihovna v Brně, Knihovna Akademie věd České republiky. Přístupné jsou i fondy digitálních kopií z jejich partnerských knihoven.",
	url: "https://books2ebooks.eu/cs"	
},
{
	code: "03", 
	name: "Europeana",
	description: "Europeana je virtuální „evropská digitální knihovna, muzeum a archiv“. Všem, kdo se zajímají o literaturu, umění, vědu, politiku, historii, architekturu, hudbu nebo film, nabízí Europeana zdarma rychlý přístup k největším evropským sbírkám a mistrovským dílům, a to z jediné virtuální knihovny. Internetový portál Europeana vám dává možnost prohlížet si a stahovat miliony zvukových a filmových záznamů, rukopisy, noviny, e-knihy, digitalizované obrazy maleb, fotografií, map a archivních dokumentů. Projekt Europeana vznikl z iniciativy Evropské komise a funguje od roku 2008.",
	url: "http://www.europeana.eu/"
},
{
	code: "04", 
	name: "Knihovny.cz",
	description: "Společný portál českých knihoven vám umožní získat knihu či jiné dokumenty, které nabízí knihovny a další subjekty, a to kdykoli a odkudkoli. Kromě knihovních fondů soustřeďuje portál na jednom místě také další knihovnické a informační služby, které lze jeho prostřednictvím využívat, aniž byste danou knihovnu museli navštívit.",
	url: "http://www.knihovny.cz/"
},
{
	code: "05", 
	name: "Manuscriptorium",
	description: "Manuscriptorium je evropská digitální knihovna rukopisů (manuskriptů). Zprostředkovává, uchovává a poskytuje digitální verze dokumentů z historických fondů, jakou jsou rukopisy, inkunábule, raně novověké tisky, mapy, listiny a další. Soustřeďuje historické zdroje, jinak rozptýlené v různých digitálních knihovnách, na jednom portálu a nabízí vám nejsnadnější cestu pro zjištění informací o fyzickém dokumentu, nebo přímo k zobrazení jeho digitální kopie. Manuscriptorium disponuje více než 5 miliony digitálních obrazů.",
	url: "http://www.manuscriptorium.com/cs"
},
{
	code: "06", 
	name: "Souborný katalog ČR",
	description: "Souborný katalog ČR obsahuje elektronické záznamy českých a zahraničních dokumentů, které jsou dostupné ve fondech českých knihoven a institucí. V současné době je zde více než 6 milionů záznamů českých a zahraničních monografií, speciálních dokumentů, seriálů (časopisy, sborníky, zprávy z konferencí apod.) a článků (v samostatné databázi).",
	url: "http://new.caslin.cz/"
},
{
	code: "07", 
	name: "Virtuální národní fonotéka",
	description: "Virtuální národní fonotéka je projektem Moravské zemské knihovny v Brně. Jedná se o databázi zvukových dokumentů, které jsou uložené v kterékoli knihovně, archivu, soukromé instituci i u soukromých osob v České republice. Portál vyhledává zvukové nahrávky a informuje o tom, kde se nachází a na jakém nosiči. Nabízí vám přístup k zajímavým nahrávkám z celého světa, k projektům spojeným s kulturním dědictvím zaznamenaným na zvukových nosičích a umožňuje nahlížení do světových knihoven a jejich fonoték.",
	url: "https://www.narodnifonoteka.cz/"
},
{
	code: "08", 
	name: "Virtuální polytechnická knihovna",
	description: "Virtuální polytechnická knihovna (VPK) je projekt, který vznikl z iniciativy především technicky zaměřených českých knihoven. Jeho smyslem bylo zlepšit dostupnost informačních zdrojů bez ohledu na to, kde se momentálně nacházíte. K tomuto účelu sjednotily fondy odborných časopisů tematicky zaměřených na techniku a související přírodní vědy, společenské vědy a medicínu, které jsou uchovávané v knihovnách zapojených do VPK. Vedle Souborného katalogu VPK vám nabízí též unikátní systém dodávání článků v elektronické nebo tištěné podobě, a to i ze zahraničních knihoven.",
	url: "https://www.techlib.cz/cs/2892-virtualni-polytechnicka-knihovna"
},
{
	code: "09", 
	name: "Portál Historické fondy",
	description: "Cílem projektu bylo vytvoření souborného katalogu historických fondů Moravské zemské knihovny (MZK), jejichž evidence již neodpovídala současným požadavkům na katalogizaci v online prostředí. Díky novému systému jsou zde přístupné staré tisky z fondů MZK a do projektu se v budoucnu zapojí i další instituce.",
	url: "https://www.historickefondy.cz/"
},
{
	code: "10", 
	name: "Databáze národních autorit NK ČR",
	description: "Portál Národní autority ČR soustředí na jednom místě zatím mnohdy roztříštěné informace o problematice (v nejširším slova smyslu) tvorby a využívání souborů národních autorit všech typů. Vytváření národních jmenných a věcných národních autorit usnadňuje vyhledávání v databázích knihoven.",
	url: "http://aleph.nkp.cz/F/?func=file&file_name=find-a&local_base=aut"
},
{
	code: "11", 
	name: "Jednotná informační brána",
	description: "Jednotná informační brána (JIB) je společný projekt Národní knihovny České republiky a Univerzity Karlova v Praze zacílený na sjednocení různorodých informačních zdrojů. Jednotná informační brána je portál, který již od roku 2002 slouží k vyhledávání bibliografických záznamů. Umožňuje vám z jednoho místa vstupovat do českých a zahraničních katalogů knihoven, souborných katalogů, databází a dalších informačních zdrojů. Zároveň zde můžete vyhledávat plné texty dokumentů, recenze knih nebo si objednat elektronické dodání dokumentu. JIB poskytuje také informace o existenci zdrojů, které nejsou volně přístupné.",
	url: "http://www.jib.cz/"
},
{
	code: "12", 
	name: "ObálkyKnih.cz",
	description: "Služba obalkyknih.cz vznikla v roce 2008 a v současné době ji provozuje Jihočeská vědecká knihovna v Českých Budějovicích. Díky ní si můžete v katalozích knihoven prohlédnout náhledové obrázky obálek knih i dalších prvků (obsahy knih, anotace apod.) či vkládat recenze knih. Tuto službu aktivně využívá většina knihoven v České republice i stovky neregistrovaných uživatelů.",
	url: "http://obalkyknih.cz/"
}
])
