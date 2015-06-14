require 'uri'
require 'net/https'
require 'net/http'
require 'json'


def value(obj, a, b)
	unless obj[a].nil?
		obj[a].kind_of?(Array) ? obj[a][0][b] : obj[a][b]
	end
end

def post(l) 

  address = l["address"].kind_of?(Array) ? l["address"][0] : l["address"]

  uri = URI.parse("http://czech-libraries.herokuapp.com/libraries")
  email = value(l, "email", "email")
  web = value(l, "url", "link")
	context = value(l, "type", "full")
	phone = l["phone"].nil? ? nil : l["phone"][0]
	response = Net::HTTP.post_form(uri, {
		"library[name]" => l["name"]["cs"], 
		"library[city]" => address["city"],
		"library[street]" => address["street"],
		"library[zip]" => address["zip"],
		"library[coordinates]" => address["coordinates"],
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

#go("ABG008")
all()
