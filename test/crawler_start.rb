require 'anemone'

options = {
  :threads => 1, 
  :verbose => true, 
  :discard_page_bodies => false, 
  :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:11.0) Gecko/20100101 Firefox/11.0", 
  :delay => 0, 
  :obey_robots_txt => true, 
  :depth_limit => 2, 
  :redirect_limit => 5, 
  :storage => nil, 
  :cookies => nil, 
  :accept_cookies => false, 
  :skip_query_strings => false, 
  :proxy_host => nil, 
  :proxy_port => false, 
  :read_timeout => nil
}


def get_links(node, base)
  return [] if !node
  links = []
  node.css("a[href]").each do |a|
    u = a['href']
    next if u.nil? or u.empty?
    u = base.scheme + "://" + base.host + u if u.start_with?("/")
    link = URI(URI.escape(u)) rescue next     
    links << link if link.host == base.host
  end
  links.uniq!
  links
end

count = 0
Anemone.crawl("http://sz.meituan.com/category/food/", options) do |core|
  core.focus_crawl{|page|
    links = []
    if page.doc
      content =  page.doc.at('#content') 
      get_links(content, page.url).each do |link|
        links << link if link.to_s =~ /food|deal/
      end     
    end
    links
  }.on_pages_like(/deal\/.+.html$/){|page|
     deal_intro = page.doc.at("#deal-intro")
      if deal_intro
        deal = {
          url: page.url.to_s,
          intro: deal_intro.at("h1").text,
          price: deal_intro.at(".deal-price > strong").text,
          image: deal_intro.at(".deal-buy-cover-img > img")[:src]
        }
        puts deal  
        count += 1
      end
  }.after_crawl { |pagestore|
    pagestore.each do |url, page|
     
    end
  }
  
end
  

puts "count = #{count}"

    
