require "nokogiri"
require 'open-uri'
require "pry"

# Obtenir le code source de la page
# https://coinmarketcap.com/all/views/all/
def get_url()
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  return page
end

# recupere les donnee du code source dans un tableau
def extract_data(page)
  all_name = []
  all_price = []
  array_name = []
  array_price = []
  all_data = Hash.new {}

  all_name = page.xpath("//tbody/tr/td[@class='text-left col-symbol']")
  all_price = page.xpath("//tbody/tr/td/a[@class='price']")

# Ajoute l'acronyme des devises dans un array
  all_name.each do |name|
    array_name.push(name.text)
  end

# Ajoute le cours des devises dans un array
  all_price.each do |price|
    # without_currency = price.text.delete "$"
    array_price.push((price.text).delete("$"))
  end
  # array_price.map!(array_price.gsub(/[$]/, ""))

  # Combine 2 array en Hash
  # price_without_currency = array_price.remove("$")
  # puts price_without_currency
  zipped = array_name.zip(array_price)
  all_data = Hash[zipped]
  return all_data
end

# affiche les donne du tableau
def display_scrapper(scrappeur)
scrappeur.each do |key, value|
  puts "#{key} #{value}"
end

end

def perform
  code_source = get_url
  scrap = extract_data(code_source)
  display_scrapper(scrap)
end
perform
