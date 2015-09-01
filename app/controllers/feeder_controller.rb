require 'open-uri'
require 'rexml/document'
class FeederController < ApplicationController

  def handle
  	sigla = params[:sigla].upcase

    library = Library.find_by(sigla:sigla)
    if library.nil? 
      library = Library.new
    elsif 
      library.phones.destroy_all
      library.faxes.destroy_all
      library.people.destroy_all
      library.emails.destroy_all
      library.websites.destroy_all
    end
      
    library.sigla = sigla.upcase

    doc = record(sigla)
    html = ""
    library.name = check(doc.elements["//varfield[@id='NAZ']/subfield[@label='a']"])
    library.code = check(doc.elements["//varfield[@id='ZKR']/subfield[@label='a']"])
    library.district = check(doc.elements["//varfield[@id='KRJ']/subfield[@label='a']"])
    library.town = check(doc.elements["//varfield[@id='KRJ']/subfield[@label='b']"])
    library.description = check(doc.elements["//varfield[@id='POI']/subfield[@label='a']"])
    library.context = check(doc.elements["//varfield[@id='TYP']/subfield[@label='b']"])

    if doc.elements["//varfield[@id='STT']"]
      library.active = false
    else
      library.active = true
    end


    addr = doc.elements["//varfield[@id='ADR']"]    
    if addr
      library.city = check(addr.elements["subfield[@label='m']"])
      library.street = check(addr.elements["subfield[@label='u']"])
      library.zip = check(addr.elements["subfield[@label='c']"])

      s_coor = check(addr.elements["subfield[@label='g']"])
      if s_coor
        coor = latlong s_coor      
        library.latitude = coor[:latitude]
        library.longitude = coor[:longitude]
      end
    end
    
    library.save

    doc.elements().each("//varfield[@id='TEL']") do |p|      
      phone = Phone.new
      phone.phone = check(p.elements["subfield[@label='a']"])
      library.phones.push(phone)
    end



    doc.elements().each("//varfield[@id='FAX']") do |f|      
      fax = Fax.new
      fax.fax = check(f.elements["subfield[@label='a']"])
      library.faxes.push(fax)
    end

    doc.elements().each("//varfield[@id='JMN']") do |p|      
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
    end    

    doc.elements().each("//varfield[@id='EML']") do |e|      
      email = Email.new
      email.email = check(e.elements["subfield[@label='u']"])
      email.note = check(e.elements["subfield[@label='z']"])
      library.emails.push(email)
    end    

    doc.elements().each("//varfield[@id='URL']") do |w|      
      website = Website.new
      website.url = check(w.elements["subfield[@label='u']"])
      website.note = check(w.elements["subfield[@label='z']"])
      library.websites.push(website)
    end    
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
