require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Définie une fonction get_the_email_of_a_townhall_from_its_webpage avec comme paramètre l'url de la page de la mairie (townhall_url)
def get_the_email_of_a_townhall_from_its_webpage (townhall_URL)
    page = Nokogiri::HTML(open(townhall_URL))
    name_town = page.xpath("/html/body/div[1]/main/section[1]/div/div/div/h1").text
    mail_adress = page.xpath("/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    return name_town, mail_adress
end

# Définie une fonction get_all_the_urls_of_val_doise_townhalls sans paramètres!
def get_all_the_urls_of_val_doise_townhalls
    url_parent = "http://annuaire-des-mairies.com/" # url de la page "parent" 
    page = Nokogiri::HTML(open(url_parent+"/val-d-oise.html"))
    urls_array = page.xpath('//a[@class = "lientxt"]').map { |node| url_parent + node.attributes["href"].value[1..-1] }
    return urls_array 
end

# Définie la fonction get_name_email_val_doise sans paramètres qui donne le nom et le mail de la mairie
def get_name_email_val_doise
    result = []
    list_url = get_all_the_urls_of_val_doise_townhalls # Récupérer la liste des urls des pages de villes
    # Récupérer pour chaque ville le nom et le mail!
    list_url.each { |town_url| name, mail = get_the_email_of_a_townhall_from_its_webpage(town_url); result.push({:name => name.to_s, :email => mail}) }
    puts result; 
end

def perform
    get_name_email_val_doise
end

perform