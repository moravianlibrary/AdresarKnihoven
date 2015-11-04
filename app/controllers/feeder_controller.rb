require 'open-uri'
require 'net/http'
require 'rexml/document'
class FeederController < ApplicationController



  def sigla
    sigla = params[:sigla].upcase
    doc = record("sig", sigla)
    if doc.nil?
      render :text => "nok",:content_type => "text/plain"
    else
      handle(sigla, doc)
      render :text => "ok",:content_type => "text/plain"
    end    
  end

  def sysno
    sysno = params[:sysno]
    doc = record("sys", sysno)
    sigla = check(doc.elements["//varfield[@id='SGL']/subfield[@label='a']"]) unless doc.nil?
    if sigla.nil?
      render :text => "nok",:content_type => "text/plain"
    else
      handle(sigla, doc)
      render :text => "ok",:content_type => "text/plain"
    end
  end


  def handle(sigla, doc)
  	

    library = Library.find_by(sigla:sigla)
    if library.nil? 
      library = Library.new
    elsif 
      library.phones.destroy_all
      library.faxes.destroy_all
      library.people.destroy_all
      library.emails.destroy_all
      library.websites.destroy_all
      library.branches.destroy_all
      library.opening_hour.destroy if library.opening_hour
      library.services.destroy_all
      library.projects.destroy_all
    end
      
    library.sigla = sigla.upcase

    
    library.name = check(doc.elements["//varfield[@id='NAZ']/subfield[@label='a']"])    
    library.name_en = check(doc.elements["//varfield[@id='VAR' and @i1='2']/subfield[@label='a']"])

    library.code = check(doc.elements["//varfield[@id='ZKR']/subfield[@label='a']"])
    library.region = check(doc.elements["//varfield[@id='KRJ']/subfield[@label='a']"])
    library.district = check(doc.elements["//varfield[@id='KRJ']/subfield[@label='b']"])
    library.description = check(doc.elements["//varfield[@id='POI']/subfield[@label='a']"])
    library.context = check(doc.elements["//varfield[@id='TYP']/subfield[@label='b']"])
    library.ico = check(doc.elements["//varfield[@id='ICO']/subfield[@label='a']"])
    library.dic = check(doc.elements["//varfield[@id='ICO']/subfield[@label='b']"])

    library.mvs_description = check(doc.elements["//varfield[@id='MVS']/subfield[@label='c']"])
    library.mvs_url = check(doc.elements["//varfield[@id='MVS']/subfield[@label='u']"])

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
    

    otd = doc.elements["//varfield[@id='OTD']"]    
    if otd
      oh = OpeningHour.new
      oh.library = library
      oh.mo = check(otd.elements["subfield[@label='1']"])
      oh.tu = check(otd.elements["subfield[@label='2']"])
      oh.we = check(otd.elements["subfield[@label='3']"])
      oh.th = check(otd.elements["subfield[@label='4']"])
      oh.fr = check(otd.elements["subfield[@label='5']"])
      oh.sa = check(otd.elements["subfield[@label='6']"])
      oh.su = check(otd.elements["subfield[@label='7']"])
      oh.note = check(otd.elements["subfield[@label='p']"])
    end
    

    library.save



    phone_array = doc.elements["//varfield[@id='TEL']"]
    if phone_array
      phone_array.elements().each("subfield[@label='a']") do |p|
        phone = Phone.new
        phone.phone = check(p)
        library.phones.push(phone)
      end
    end

    fax_array = doc.elements["//varfield[@id='FAX']"]
    if fax_array
      fax_array.elements().each("subfield[@label='a']") do |f|      
        fax = Fax.new
        fax.fax = check(f)
        library.faxes.push(fax)
      end
    end

    service_array = doc.elements["//varfield[@id='SLU']"]
    if service_array
      service_array.elements().each("subfield[@label='a']") do |s|      
        service_code = check(s)
        if service_code
          service = Service.find_by(code: service_code)
          library.services << service unless service.nil?
        end
      end
    end    

    project_array = doc.elements["//varfield[@id='PRK']"]
    if project_array
      project_array.elements().each("subfield[@label='a']") do |p|      
        project_code = check(p)
        if project_code
          project = Project.find_by(code: project_code)
          library.projects << project unless project.nil?
        end
      end
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

    doc.elements().each("//varfield[@id='POB']") do |b|      
      branch = Branch.new
      branch.name = check(b.elements["subfield[@label='n']"])
      branch.address = check(b.elements["subfield[@label='a']"])
      
      s_coor = check(b.elements["subfield[@label='g']"])
      if s_coor
        coor = latlong s_coor      
        branch.latitude = coor[:latitude]
        branch.longitude = coor[:longitude]
      end

      library.branches.push(branch)
    end    

    

    #respond_to do |format|
    #  format.json { head :ok }  
    #  format.html { head :ok }  
    #end
  end


  def show
    value = params[:sigla]
    key = "sig"
    if params[:sys]
      key = "sys"
    end
    xml = record(key, value)        
    render :text => xml,:content_type => "text/plain"
  end


def check(value)
  return value.text unless value.nil?
end

def set_number(key, value)
  url = "http://aleph.nkp.cz/X?op=find&find_code=wrd&base=ADR&request=" + key + "=" + value
  xml_data = Net::HTTP.get_response(URI.parse(url)).body
  doc = REXML::Document.new(xml_data)
  el = doc.elements().to_a('find/set_number').first
  check(el)
end

def record(key, value)
  num = set_number(key, value)
  unless num.nil?
    url = "http://aleph.nkp.cz/X?op=present&set_entry=000000001&format=marc&set_no=" + num
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    REXML::Document.new(xml_data)
  end
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
