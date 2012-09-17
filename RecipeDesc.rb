require 'rubygems'  
require 'active_record' 
require 'nokogiri'
require 'open-uri' 
ActiveRecord::Base.establish_connection(  
:adapter=> "mysql2",  
:host => "localhost",
:username => "root",
:password => "webonise6186", 
:database=> "scrape",
)  
  

class RecipeDesc < ActiveRecord::Base
end
url = "http://www.simplyrecipes.com/recipe-index.php"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
links = doc.search('a').map { |a| [a['href'],a.content]}
for i in 0...links.length
puts links[i][0].to_s + "================="
url=links[i][0]
doc = Nokogiri::HTML(open(url))
str1 =doc.at_css(".entry-photo img").attribute('src').to_s
str2 = doc.at_css(".center p").content
str3 =doc.at_css(".ingredient").content
str4 =doc.at_css("#recipe-method").content
Recipedesc.create(:imagesrc => str1, :descr => str2, :ingredients => str3, :method => str4)
puts str1
end
