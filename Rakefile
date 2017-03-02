# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :data do
  desc "Grab data from external sources"
  task :grab => :environment do

    require 'open-uri'
    require 'anemone'
    require 'nokogiri'

    # metro beaubien is at latitude: 45.5355332 , longitude: -73.6045011
    base_url = 'http://www.kijiji.ca'
    search_params = '/b-immobilier/ville-de-montreal/beaubien/'
    search_token = 'k0c34l1700281'

    anemone_opts = {
      user_agent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', # http://www.useragentstring.com/index.php?id=19841
    }

    annonces = []

    Anemone.crawl("#{base_url}#{search_params}#{search_token}", anemone_opts) do |anemone|
      anemone.on_every_page do |page|
        puts page.url
        page.doc.css('.search-item').each do |item|
          title = item.css('.title a').first.text.strip
          url = "#{base_url}#{item.css('.title a').first['href']}"
          price = item.css('.price').first.text.strip
          price = price =~ /Sur demande/ ? nil : price.sub(',', '.').gsub(/[^\d\.]/, '').to_f
          date_posted = item.css('.date-posted').first.text.strip
          if date_posted =~ /^\D/
            date_posted = Time.now.strftime('%Y-%m-%d')
          else
            {
              'janvier' => 'January',
              'février' => 'February',
              'mars' => 'March',
              'avril' => 'April',
              'mai' => 'May',
              'juin' => 'June',
              'juillet' => 'July',
              'août' => 'August',
              'septembre' => 'September',
              'octobre' => 'October',
              'novembre' => 'November',
              'décembre' => 'December',
            }.each { |k, v|
              date_posted.sub!(k, v)
            }
            begin
              puts "date_posted: #{date_posted.inspect}"
              date_posted = Time.strptime(date_posted, '%e-%B-%y').strftime('%Y-%m-%d')
            rescue
              # puts "Failed"
              exit
            end
          end

          if title !~ /^Recherch/ && price && price < 1000.0
            annonce = Annonce.find_by_url(url)
            annonce_params = {
              url: url,
              title: title,
              price: price,
              date_posted: date_posted
            }
            if annonce.nil?
              annonce_page_doc = Nokogiri::HTML(open(url))
              latitude = annonce_page_doc.css("meta[property='og:latitude']").first
              if latitude
                annonce_params[:latitude] = latitude['content'].to_f
              end
              longitude = annonce_page_doc.css("meta[property='og:longitude']").first
              if longitude
                annonce_params[:longitude] = longitude['content'].to_f
              end
              puts "Saving Annonce: '#{annonce_params.inspect}'"
              Annonce.create(annonce_params)
            else
              puts "Annonce is already there: '#{annonce.title}'"
            end
          end
        end
      end
      anemone.focus_crawl do |page|
        page.links.select{|link| link.to_s =~ /#{base_url}#{search_params}/ && link.to_s =~ /\/page-/ }
      end
    end

  end
end
