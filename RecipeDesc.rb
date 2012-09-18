require 'rubygems'  
require 'active_record' 
require 'nokogiri'
require 'open-uri' 
ActiveRecord::Base.establish_connection(  
:adapter=> "mysql2",  
:host => "localhost",
:username => "root",
:password => "webonise6186", 
:database=> "recipesdb",
)  
#creating connection to mysql  
class Recipe < ActiveRecord::Base  
end			#mapping class to database
class RecipeDesc < ActiveRecord::Base
end			#mapping class to database
url = "http://www.simplyrecipes.com/recipe-index.php"
doc = Nokogiri::HTML(open(url))						#opening main url 
links = doc.search('a').map { |a| [a['href'],a.content]}		#copying all links from page to links array
for i in 10...15
Recipe.create(:link => links[i][0], :name => links[i][1])
#for putting data into recipes table containing recipe name and link
puts links[i][0]
end
for i in 10...15
url1 = links[i][0]
puts url1
doc1 = Nokogiri::HTML(open(url1))				#opening inner links for retrieving data
str1 =doc1.at_css(".entry-photo img")	
puts str1
if str1.to_s == ''								#for checking str1 contains img tag or not
imgsrc=nil
else
imgsrc=str1.attribute('src').to_s				#copying image src to local variable
end
descrp = doc1.at_css(".center p").content		#copying the description
ingrnt =doc1.at_css("#recipe-ingredients").content		#copying the ingredients
metd =doc1.at_css("#recipe-method").content		#copying method into local variable
RecipeDesc.create(:imagesrc => imgsrc, :descr => descrp, :ingredients => ingrnt, :method => metd)
#for putting data into recipe_descs table 
end
