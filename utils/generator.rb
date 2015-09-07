require 'uri'
require 'net/https'
require 'net/http'


def go(sigla=nil)
	if sigla.nil? || sigla.empty?
		return	
	end
	port = 3000
	#url = "http://localhost:3000/feeder/" + sigla + "/"
	url = "http://czech-libraries.herokuapp.com/feeder/" + sigla + "/"
	puts url
	encoded_url = URI.encode(url)
	uri = URI.parse(encoded_url)
	http = Net::HTTP.new(uri.host, uri.port)
	#http.use_ssl = true
	#http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri)
	response = http.request(request)
	if !response.body.empty?
		puts "error"
	end
	#j = JSON.parse(response.body)
	#post(j["library"])
end


def all
	count = 0
	File.open("sigla-list.txt", "r") do |f|  		
  		f.each_line do |l|
    		count = count + 1
    		if count > 600 
    			return
    		end
    		puts count.to_s
    		go(l.strip)
  		end
	end
end
all()
