require "nokogiri"
require 'open-uri'
require "pry"

# Obtenir le code source de la page
def get_url(url=nil)
  if url == nil
    page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  else
    page = Nokogiri::HTML(open("#{url}"))
  end
    return page
end

#Recupe des l'url des liens des villes du 95
def get_townhall_urls(townhall_url)
    all_links = []
    array_links = []

    # => recupere le code source des liens
    all_links = townhall_url.xpath("//p/a/@href")

    # =>  Ajoute dans un array les url des liens
    all_links.each do |link|

      # => Ajoute dans un array "l'url + lien"
       # je delete le point en trop au debut du lien
       # je slice pour supprimer les html les 5 dernier charatere car pas de point du au delete
     array_links.push(('https://www.annuaire-des-mairies.com'+ (link.text).delete(".")).slice(0..-5))
    end
    #  je map pour le rajouter le"." + "html" a la fin de chaque entre
    array_links.map!{|str| str + ".html"}
  return array_links
end


# recupere les donnee du code source dans un tableau
def get_townhall_email(townhall_url)
  all_email = []
  array_email = []
  # recupere code source des emails
  all_email = townhall_url.xpath("(//tbody/tr[4]/td[2])[1]")

# Ajoute dans un array les emails
  all_email.each do |email|
    array_email.push(email.text)
  end
  return array_email
end

# recupere les donnee du code source dans un tableau
def get_townhall(townhall_url)
 all_town = []
 array_town = []
 third = []
 # recupere code source des villes
 all_town = townhall_url.xpath("(//tbody/tr[1]/td[2])[1]")
# Ajoute dans un array les villes
 all_town.each do |town|
   array_town.push(town.text)

   # array_town.push((town.text).split('-'))
   # third = array_town[3]
   # array_town.push((town.text).split('-', -1))
 end
 # puts array_town
 return array_town
end

# combine les array "ville" et "email" en hash
def zipper(town,email)
data = Hash.new{}
zipped = town.zip(email)
data = Hash[zipped]
  return data
end

# affiche les donnes du Hash composer des villes et emails
def display_email(scrappeur)
  scrappeur.each do |town, email|
      if email == ""
        puts "#{town} => CETTE MAIRIE NA PAS D'EMAIL"
      else
      puts "#{town} => #{email}"
    end
  end
end


# => Centralisation des Appels de fonction
def perform

  code_source = get_url(nil)
  # => methode pour recuperer tous les url des lien du 95
  url = get_townhall_urls(code_source)
  email = []
  # => Parcour Les url recuperer
  # => envoi les url dans nokogiri pour avoir le code source
  url.each do |scrap|
    town = get_townhall(get_url(scrap))
    email = get_townhall_email(get_url(scrap))
    data = zipper(town,email)
      display_email(data)
  end
end
# array_town = "a-b-c-d"
# array_town.split('-', 3).to_a.slice(3)
# puts array_town
perform
