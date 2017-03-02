# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :data do
  desc "Grab data from external sources"
  task :grab => :environment do

    require 'anemone'

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

          if title !~ /^Recherch/ && price && price < 1000.0
            annonce = {
              url: url,
              title: title,
              price: price
            }
            puts annonce.inspect
          end
        end
      end
      anemone.focus_crawl do |page|
        page.links.select{|link| link.to_s =~ /#{base_url}#{search_params}/ && link.to_s =~ /\/page-/ }
      end
    end

  end
end
