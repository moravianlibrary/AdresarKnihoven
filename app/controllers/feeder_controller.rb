require 'open-uri'
class FeederController < ApplicationController

  def handle
  	sigla = params[:sigla]
    #url = "http://aleph.nkp.cz/X?op=find&find_code=wrd&base=ADR&request=sig=" + sigla
    
    #xml_data = Net::HTTP.get_response(URI.parse(url)).body
    #doc = Nokogiri::XML(xml_data)
    #logger.debug doc
    l = Library.new

    doc = record(sigla)
    html = ""
    name = doc.elements["//varfield[@id='NAZ']/subfield[@label='a']"].text
    code = doc.elements["//varfield[@id='ZKR']/subfield[@label='a']"].text
    district = doc.elements["//varfield[@id='KRJ']/subfield[@label='a']"].text
    town = doc.elements["//varfield[@id='KRJ']/subfield[@label='b']"].text
    description = doc.elements["//varfield[@id='POI']/subfield[@label='a']"].text
    addr = doc.elements["//varfield[@id='ADR']"]
    city = addr.elements["subfield[@label='m']"].text
    street = addr.elements["subfield[@label='u']"].text
    zip = addr.elements["subfield[@label='c']"].text
    s_coor = addr.elements["subfield[@label='g']"].text
    coor = latlong s_coor
    latitude = coor[:latitude]
    longitude = coor[:longitude]
    context = doc.elements["//varfield[@id='TYP']/subfield[@label='b']"].text

    l.name = name
    l.description = description
    l.code = code
    l.city = city
    l.street = street
    l.zip = zip
    l.latitude = latitude
    l.longitude = longitude
    l.sigla = sigla.upcase
    l.context = context
    l.district = district
    l.town = town
    l.save

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
