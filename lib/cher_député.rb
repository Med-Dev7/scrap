# require "nokogiri"
# require 'open-uri'
#
# # Obtenir le code source de la page
# # https://coinmarketcap.com/all/views/all/
# def get_url()
#   page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
#   return page
# end
#
# # recupere les donnee du code source dans un tableau
# def extract_data(url)
#   all_crypto_data = url.xpath{//}
#   return all_crypto_data
# end
#
# # affiche les donne du tableau
# def display_scrapper()
#
# end
#
#
# def perform
#   codeSource = get-url
#   puts get-url
#   array_crypto_data = extract_data(codeSource)
#   crypto_scrapper(array_crypto)
# end
