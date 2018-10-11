require 'rubygems'
require 'nokogiri'
require 'open-uri'

def listedeputes(url)
	tabname = []
	doc = Nokogiri::HTML(open(url))
	links = doc.css("https://www.nosdeputes.fr/deputes")

	links.each{
		|link|
		tabname << link.text
	}
	return tabname
end

def NomPrenom(tabDepute)

tabNomPrenom = []

	tabDepute.each {
		|nom|
		if nom[0,3] == "M. "
			nom[0,3] = ""
		else
			nom[0,4] = ""
		end
	}

	tabDepute.each{
		|name|
		tabNomPrenom << [name.split[0], name.split[1]]
	}
	return tabNomPrenom
end