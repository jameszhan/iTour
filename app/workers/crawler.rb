
class Crawler
  
  @queue = :crawler_queue
  
  SITES = YAML.load_file("sites.yaml")

  def self.perform(site, type)
    map = SITE[site]
    if map
      
    else
      throw "Unsupport Site #{site}."
    end
  end
  
end