require 'nokogiri'
require 'open-uri'
require 'pry'
require 'resolv-replace'

class Scraper

  def self.scrape_survivors
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"))
    survivors = []
    survivor_list = page.css('div#fpsurvivors div.fplinks div.box div.row div.cell')
    survivor_list.each do |survivor|
      name = survivor.css('div.link a').text
      bio_link = survivor.css('div.link a').attribute('href').value
      image_url  = survivor.css('div.image a img').attribute('src').value
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
    perk_name_extract = item.css('table.wikitable.sortable tr th[2] a[1]')
    perk_name = perk_name_extract.map {|name| name.attribute('title').text.gsub("\n", "")}
    perk_description_extract = item.css('table.wikitable.sortable tbody tr td')
    perk_description = perk_description_extract.map {|description| description.text.gsub("\n", "")}
    perk_hash = Hash[perk_name.zip(perk_description.map {|i| i.include?(',') ? (i.split /, /) : i})]
    perk_hash.each do |name, description|
        if counter <= 74
          perk_role = "survivor"
        elsif counter >= 75
          perk_role = "killer"
        end
          perk_complete = {:name => name, :description => description, :count => counter, :role => perk_role}
          all_perks << perk_complete
        counter += 1
       end
     end
     all_perks

   end

def self.scrape_perk_images
    page = Nokogiri::HTML(open("https://deadbydaylight.gamepedia.com/Perks"))
    page.css('table.wikitable.sortable tbody tr th a').each do |perk|
      image_url = nil
      unedited_name = nil
      image_url = perk.css('img').attribute('src')
      unedited_name = perk.css('img').attribute('alt')
      if image_url != nil || unedited_name != nil
        edited_name = unedited_name.value.partition(' ').last
        url = image_url.value
        File.open("public/images/perks/#{edited_name}", "wb") do |f|
        f.write(open(url).read)
        end
      end
    end
end

end


#JSON data source currently returning 503 error - returning to web scraping method and retiring JSON source
=begin
  def self.scrape_perks
    all_perks = []
    survivor_list = []
    unedited_survivor_list = self.scrape_survivors
    unedited_survivor_list.each do |survivor|
      survivor_edited = survivor[:name].downcase.gsub(" ", "")
      survivor_name = {:name => survivor_edited}
      survivor_list << survivor_name
    end
    killer_list = []
    unedited_killer_list = self.scrape_killers
    unedited_killer_list.each do |killer|
      killer_shortened = killer[:name].downcase.gsub("The", "").gsub(" ", "")
      killer_name = {:name => killer_shortened}
      killer_list << killer_name
    end

    perk_name_page = Net::HTTP.get(URI.parse('https://dbd.onteh.net.au/api.php?perks'))
    json = JSON.parse(perk_name_page)
    json.each do |name|
      perk_detail = Net::HTTP.get(URI.parse('https://dbd.onteh.net.au/api.php?perkinfo='"#{name}"))
      json_detail = JSON.parse(perk_detail)
      perk_name = json_detail.fetch("name")
      perk_description = json_detail.fetch("lines")
      perk_owner = json_detail.fetch("character", nil)
      perk_teachable = json_detail.fetch("teachable", nil)
      perk_role = json_detail.fetch("role", nil)
      if perk_role != nil
        perk_complete = {:name => perk_name, :description => perk_description, :role => perk_role}
        all_perks << perk_complete
      elsif perk_owner == nil
        if survivor_list.select {|s| s[:name].include?(perk_owner.downcase.gsub(" ", ""))}
          perk_role = "survivor"
        else killer_list.select {|s| s[:name].include?(perk_owner.downcase.gsub("the", "").gsub(" ", ""))}
          perk_role = "killer"
        end
        perk_complete = {:name => perk_name, :description => perk_description, :perk_owner => perk_owner, :teachable => perk_teachable, :role => perk_role}
        all_perks << perk_complete
      end
    end
    all_perks
    binding.pry
  #end
scrape_perks
=end
