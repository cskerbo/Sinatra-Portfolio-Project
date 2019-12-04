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
    all_perks = []
    perk_name_page = Net::HTTP.get(URI.parse('https://dbd.onteh.net.au/api.php?perks'))
    json = JSON.parse(perk_name_page)
    json.each do |name|
      perk_detail = Net::HTTP.get(URI.parse('https://dbd.onteh.net.au/api.php?perkinfo='"#{name}"))
      json_detail = JSON.parse(perk_detail)
      perk_name = json_detail.fetch("name")
      perk_description = json_detail.fetch("lines")
      perk_owner = json_detail.fetch("character", nil)
      perk_teachable = json_detail.fetch("teachable", nil)
      if perk_owner == nil || perk_teachable == nil
        perk_complete = {:name => perk_name, :description => perk_description}
        all_perks << perk_complete
      else
        perk_complete = {:name => perk_name, :description => perk_description, :perk_owner => perk_owner, :teachable => perk_teachable}
        all_perks << perk_complete
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
  scrape_perk_images
end
