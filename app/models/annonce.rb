class Annonce < ActiveRecord::Base
  validates_uniqueness_of :url

  PLACES = {
    appartement: {
      longitude: -73.6045011, latitude: 45.5355332, 
      search_terms: [
        '/b-a-louer/ville-de-montreal/appartement/',
      ]
    },
    # metro_jean_talon: {
    #   longitude: -73.6136422, latitude: 45.5395565, 
    #   search_terms: [
    #     '/b-a-louer/ville-de-montreal/jean-talon/'
    #   ]
    # },
    #metro_mont_royal: {
    #  longitude: -73.5838408, latitude: 45.5245259, 
    #  search_terms: [
    #    '/b-a-louer/ville-de-montreal/mont-royal/'
    #  ]
    #},
    #metro_jarry: {
    #  longitude: -73.647853, latitude: 45.5421026, 
    #  search_terms: [
    #    '/b-a-louer/ville-de-montreal/jarry/'
    #  ]
    #},
  }

  # Supported states:
  # unjudged, rejected, retained

  def self.unjudged
    where("state = 'unjudged' OR state = 'retained'") #.where("latitude IS NOT NULL")
  end

end
