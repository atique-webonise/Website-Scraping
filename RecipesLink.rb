require 'rubygems'  
require 'active_record' 
require 'nokogiri'
require 'open-uri' 
ActiveRecord::Base.establish_connection(  
:adapter=> "mysql2",  
:host => "localhost",
:username => "root",
:password => "webonise6186", 
:database=> "students",
:table=> "recipes"
)  
  
class Recipe < ActiveRecord::Base  
end
url = "http://www.simplyrecipes.com/recipe-index.php"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
links = doc.search('a').map { |a| [a['href'],a.content]}
for i in 0...links.length
Recipe.create(:link => links[i][0], :name => links[i][1])
end
