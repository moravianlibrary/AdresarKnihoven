
def latlong(dms_pair)
  #match = dms_pair.match(/(\d\d)°(\d\d)'(\d\d.)'' (\d\d)° (\d\d)' (\d\d)''/)
  match = dms_pair.match(/(\d{1,2})°(\d{1,2})'(\d{1,2}).*".*N, (\d{1,2})°(\d{1,2})'(\d{1,2}).*"/)
  puts match[1].to_f
  puts match[2].to_f
  puts match[3].to_f
  latitude = match[1].to_f + match[2].to_f / 60 + match[3].to_f / 3600
  longitude = match[4].to_f + match[5].to_f / 60 + match[6].to_f / 3600
  puts latitude
  puts longitude
  #49.20861111111111
  #16.593888888888888

  {:latitude=>latitude, :longitude=>longitude}
end


#c = "49°12'31.14\"N"
c = "49°12'31.14\"N, 16°35'38.5\"E"

puts c
l = latlong c
puts c