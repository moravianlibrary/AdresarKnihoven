require 'open-uri'
class FeederController < ApplicationController

  def handle
  	sigla = params[:sigla].upcase
    #url = "http://aleph.nkp.cz/X?op=find&find_code=wrd&base=ADR&request=sig=" + sigla
    
    #xml_data = Net::HTTP.get_response(URI.parse(url)).body
    #doc = Nokogiri::XML(xml_data)
    #logger.debug doc

    library = Library.find_by(sigla:sigla)
    if library.nil? 
      library = Library.new
    elsif 
      library.phones.destroy_all
      library.faxes.destroy_all
      library.people.destroy_all
    end
      

    doc = record(sigla)
    html = ""
    name = doc.elements["//varfield[@id='NAZ']/subfield[@label='a']"].text
    code = doc.elements["//varfield[@id='ZKR']/subfield[@label='a']"].text
    district = doc.elements["//varfield[@id='KRJ']/subfield[@label='a']"].text
    town = doc.elements["//varfield[@id='KRJ']/subfield[@label='b']"].text
    description = check(doc.elements["//varfield[@id='POI']/subfield[@label='a']"])
    addr = doc.elements["//varfield[@id='ADR']"]
    city = addr.elements["subfield[@label='m']"].text
    street = addr.elements["subfield[@label='u']"].text
    zip = addr.elements["subfield[@label='c']"].text
    s_coor = addr.elements["subfield[@label='g']"].text
    coor = latlong s_coor
    latitude = coor[:latitude]
    longitude = coor[:longitude]
    context = doc.elements["//varfield[@id='TYP']/subfield[@label='b']"].text

    library.name = name
    library.description = description
    library.code = code
    library.city = city
    library.street = street
    library.zip = zip
    library.latitude = latitude
    library.longitude = longitude
    library.sigla = sigla.upcase
    library.context = context
    library.district = district
    library.town = town
    library.save

    html = add(html, "name", name)
    html = add(html, "code", code)
    html = add(html, "city", city)    
    html = add(html, "zip", zip)    
    html = add(html, "street", street)    
    html = add(html, "district", district)    
    html = add(html, "town", town)    
    html = add(html, "context", context)    
    html = add(html, "sigla", sigla)    
    html = add(html, "description", description)    


    html = add(html, "lat", latitude)    
    html = add(html, "lon", longitude)    
    
    tel = doc.elements["//varfield[@id='TEL']"]
    tel.elements().each("subfield[@label='a']") do |t|
      html = add(html, "phone", t.text)
      phone = Phone.new
      phone.phone = t.text
      library.phones.push(phone)
    end

    fax = doc.elements["//varfield[@id='FAX']"]
    fax.elements().each("subfield[@label='a']") do |t|      
      html = add(html, "fax", t.text)
      f = Fax.new
      f.fax = t.text
      library.faxes.push(f)
    end

    #people = doc.elements["//varfield[@id='JMN']"]
    doc.elements().each("//varfield[@id='JMN']") do |p|      
      
      html = add(html, "person", p.elements["subfield[@label='t']"])
      person = Person.new
      person.first_name = check(p.elements["subfield[@label='k']"])
      person.last_name = check(p.elements["subfield[@label='p']"])
      person.degree1 = check(p.elements["subfield[@label='t']"])
      person.degree2 = check(p.elements["subfield[@label='c']"])
      person.phone = check(p.elements["subfield[@label='f']"])
      person.email = check(p.elements["subfield[@label='e']"])
      person.addressing = check(p.elements["subfield[@label='o']"])
      person.role = check(p.elements["subfield[@label='r']"])
      library.people.push(person)
      #f.fax = t.text
      #library.faxes.push(f)
    end    

    #/subfield[@label='a']"]
    #.each |tel| do 
    #  html += tel.elements["/subfield[@label='a']"].text + "\n"
    #end
    
    #html = doc.xpath("//set_number").text
    render :text => html,:content_type => "text/plain"
    #respond_to do |format|
    #  format.json { head :ok }  
    #  format.html { head :ok }  
    #end
  end


  def show
    sigla = params[:sigla]  
    xml = record(sigla)
    html = xml
    render :text => html,:content_type => "text/plain"
  end


def check(value)
  return value.text unless value.nil?
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

def latlong(coor)
  match = coor.match(/(\d*)°(\d*)'([0-9]*\.?[0-9]+)".*N, (\d*)°(\d*)'([0-9]*\.?[0-9]+)"/)
  latitude = match[1].to_f + match[2].to_f / 60 + match[3].to_f / 3600
  longitude = match[4].to_f + match[5].to_f / 60 + match[6].to_f / 3600
  {:latitude=>latitude.round(8), :longitude=>longitude.round(8)}
end

def add(s, k, v) 
  s+ "\n---" + k + "---\n" + v.to_s + "\n"
end

end
