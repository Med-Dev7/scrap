require "nokogiri"
require 'open-uri'
require "pry"
# Obtenir le code source de la page
# https://coinmarketcap.com/all/views/all/
def get_url()
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  return page
end
#
# All Elements 	* 	//*
# All P Elements 	p 	//p
# All Child Elements 	p > * 	//p/*
# Element By ID 	#foo 	//*[@id=’foo’]
# Element By Class 	.foo 	//*[contains(@class,’foo’)] 1
# Element With Attribute 	*[title] 	//*[@title]
# First Child of All P 	p > *:first-child 	//p/*[0]
# All P with an A child 	Not possible 	//p[a]
# Next Element 	p + * 	//p/following-sibling::*[0]
# /html/body/div[2]/div[2]/div[1]/div[1]/div[3]/div[2]/div/table/tbody/tr[2]/td[3]
# recupere les donnee du code source dans un tableau
def extract_data(page)
  all_name = []
  all_price = []
  array_name = []
  array_price = []
  all_data = Hash.new {}

  all_name = page.xpath("//tbody/tr/td[@class='text-left col-symbol']")
  all_price = page.xpath("//tbody/tr/td/a[@class='price']")

  all_name.each do |name|
    array_name.push(name.text)
  end

  all_price.each do |price|
    array_price.push(price.text)
  end

  # Combine 2 array en Hash
  zipped = array_name.zip(array_price)
  all_data = Hash[zipped]
  puts all_data
  return all_data
end

# affiche les donne du tableau
def display_scrapper(scrappeur)
  return
end


def perform
  code_source = get_url
  # puts code_source
  array_crypto_data = extract_data(code_source)
  # puts array_crypto_data
  # display_scrapper(array_crypto_data)
end
perform
