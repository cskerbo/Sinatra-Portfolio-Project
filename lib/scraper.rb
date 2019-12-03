require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_survivors
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Survivors"))
    survivors = []

    survivor_list = page.css('div[style*="flex:1"]')
    survivor_list.each do |survivor|
      name = survivor.css("a").attribute("title").text
      #temporary workaround until new survivor issue on gamepedia is resolved#
      if name != "Yui Kimura"
        bio_link = survivor.css('a').attribute('href').value
        image_url  = survivor.css('img').attribute('src').value
        File.open("public/images/characters/#{name}.png", "wb") do |f|
            f.write(open(image_url).read)
        end
        bio_page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com#{bio_link}"))
        bio = bio_page.css('div.mw-parser-output i').each do |line|
          text = line.text.strip
          if text.length > 300
            survivor_info = {:name => name, :bio => text}
            survivors << survivor_info
          end
        end
      end
    end
      survivor_hash = survivors.group_by {|h1| h1[:name]}.map do |k, v|
        {:name => k, :bio => v.map {|h2| h2[:bio] }.join}
      end
    survivor_hash.each {|t| t[:character_type]="survivor"}
    survivor_hash
end
  def self.scrape_killers
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
    killers = []

    killer_list = page.css('div#fpkiller div.fplinks div.box div.row div.cell')
    killer_list.each do |killer|
      name = killer.css('div.link a').text
      bio_link = killer.css('div.link a').attribute('href').value
      image_url  = killer.css('div.image a img').attribute('src').value

      File.open("public/images/characters/#{name}.png", "wb") do |f|
          f.write(open(image_url).read)
      end
      bio_page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com#{bio_link}"))
      bio = bio_page.css('div.mw-parser-output i').each do |line|
        text = line.text.strip
        if text.length > 300
          killer_info = {:name => name, :bio => text}
          killers << killer_info
        end
      end
    end
    killer_hash = killers.group_by {|h1| h1[:name]}.map do |k, v|
      {:name => k, :bio => v.map {|h2| h2[:bio] }.join}
    end
    killer_hash.each {|t| t[:character_type]="killer"}
    killer_hash
  end

  def self.scrape_perks
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Perks"))
    all_perks = []

    perk_extract = page.css('div.mw-parser-output')
    counter = 1
    perk_extract.each do |item|
      perk_name = item.css('table.wikitable.sortable tr th[2] a').attribute('title').text
      image_url  = item.css('table.wikitable.sortable tr th[1] a[1] img').attribute('src').value

      description = []
      item.css('table.wikitable.sortable tr td') do |d|
        description << d.content
      end
        perk_complete = {:name => name, :description => description, :count => counter}
        all_perks << perk_complete
        counter += 1
    end
    all_perks
    binding.pry
  end
  scrape_perks
end
