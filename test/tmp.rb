
begin
  puts "&1  00.2&".gsub(/[^\d.]/, '')
rescue Exception => e
  puts e
end