
class Crawler
  
  @queue = :crawler_queue  
  SITES = YAML.load_file("#{Rails.root}/lib/sites.yaml")["SITES"]

  def self.perform(sitename, type) 
    site = SITES[sitename.upcase]
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
  end
  
end

