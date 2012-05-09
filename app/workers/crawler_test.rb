require 'anemone'
require 'yaml'
require './group_site'
require './meituan'

class String
  def constantize
    names = self.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end
end




SITES = YAML.load_file("sites.yaml")["SITES"]
sitename = "meituan".upcase
type = "play"

site = SITES[sitename]
if site
  classname = sitename.capitalize
  links = site[type]
  if links
    groupsite = classname.constantize.new(links, type)
    groupsite.start
  else
    throw "Unsupport Site #{sitename} type: #{type}."        
  end
else
  throw "Unsupport Site #{sitename}."
end


=begin
SITES["SITES"].each do|site, links| 
  classname = site.capitalize
  links.each do|type, urls|
    groupsite = constantize(classname).new(links[type], type)
    groupsite.start
  end
end

classname = "meituan".capitalize
constantize(classname).new("http://sz.meituan.com/category/food/", 'food').start
=end