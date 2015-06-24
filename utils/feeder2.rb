require 'uri'
require 'net/https'
require 'net/http'
require 'json'
require 'rexml/document'



def value(obj, a, b)
	unless obj[a].nil?
		obj[a].kind_of?(Array) ? obj[a][0][b] : obj[a][b]
	end
end



def latlong(coor)
  #match = coor.match(/(\d{1,2})°(\d{1,2})'(\d{1,2}).*".*N, (\d{1,2})°(\d{1,2})'(\d{1,2}).*"/)
  match = coor.match(/(\d*)°(\d*)'([0-9]*\.?[0-9]+)".*N, (\d*)°(\d*)'([0-9]*\.?[0-9]+)"/)

  latitude = match[1].to_f + match[2].to_f / 60 + match[3].to_f / 3600
  longitude = match[4].to_f + match[5].to_f / 60 + match[6].to_f / 3600
  {:latitude=>latitude.round(8), :longitude=>longitude.round(8)}
end

def post(l) 

  address = l["address"].kind_of?(Array) ? l["address"][0] : l["address"]

  uri = URI.parse("http://czech-libraries.herokuapp.com/libraries")
  #uri = URI.parse("http://localhost:3000/libraries")
  email = value(l, "email", "email")
  web = value(l, "url", "link")
	context = value(l, "type", "full")
	phone = l["phone"].nil? ? nil : l["phone"][0]
	longitude = nil
	latitude = nil
	if address["coordinates"]
		c = latlong address["coordinates"]
		longitude = c[:longitude]
		latitude = c[:latitude]
	end

	response = Net::HTTP.post_form(uri, {
		"library[name]" => l["name"]["cs"], 
		"library[city]" => address["city"],
		"library[street]" => address["street"],
		"library[zip]" => address["zip"],
		"library[longitude]" => longitude,
		"library[latitude]" => latitude,
		"library[code]" => l["code"], 
		"library[description]" => l["description"], 
		"library[email]" => email, 
		"library[phone]" => phone, 
		"library[district]" => l["region"]["district"], 
		"library[town]" => l["region"]["town"], 
		"library[sigla]" => l["sigla"], 
		"library[context]" => context,
		"library[url]" => web,  
	})


#puts response.body
end 

def go(sigla=nil)
	if sigla.nil? || sigla.empty?
		return	
	end
	url = "https://cpk-back.mzk.cz:8443/siglainf/getinfo?sigla=" + sigla
	puts url
	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri)
	response = http.request(request)
	j = JSON.parse(response.body)
	post(j["library"])
end


def all
File.open("sigla-list.txt", "r") do |f|
  f.each_line do |l|
    go(l)
  end
end
end


def set_number(sigla)
	url = "http://aleph.nkp.cz/X?op=find&find_code=wrd&base=ADR&request=sig=" + sigla
	xml_data = Net::HTTP.get_response(URI.parse(url)).body
	doc = REXML::Document.new(xml_data)
	return doc.elements().to_a('find/set_number').first.text
end

def record(sigla)
	num = set_number(sigla)
	puts num
	url = "http://aleph.nkp.cz/X?op=present&set_entry=000000001&format=marc&set_no=" + num
	xml_data = Net::HTTP.get_response(URI.parse(url)).body
	return REXML::Document.new(xml_data)
end

def go2(sigla)
	r = record(sigla)
	m = r.elements().to_a('present/record/metadata').first
	r.elements.each("//varfield") do |element| 
		#puts "---"
		#puts element#.attributes["id"] 
		v_id = element.attributes["id"] 
		#puts "---"
		if v_id == "NAZ"
			puts element.elements["subfield[@label='a']"].text
			puts element.elements["subfield[@label='b']"].text
			puts element.elements["subfield[@label='c']"].text
		elsif v_id == "TYP"
			puts element.elements["subfield[@label='a']"].text
			puts element.elements["subfield[@label='b']"].text
		elsif v_id == "ADR"
			puts element
			coor = element.elements["subfield[@label='g']"].text
			puts coor
			puts latlong coor
			#puts element.elements["subfield[@label='b']"].text
		end
	end
	uri = URI.parse("http://localhost:3000/feeder")
	response = Net::HTTP.post_form(uri, {
		"doc" => m 
	})


	#puts m
end

#go2("BOA001")
go2("ABA001")
#all()
