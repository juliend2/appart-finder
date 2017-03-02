class Annonce < ActiveRecord::Base
  validates_uniqueness_of :url

  PLACES = {
    metro_beaubien: {longitude: -73.6045011, latitude: 45.5355332, search_terms: ['/b-immobilier/ville-de-montreal/beaubien/', '/b-immobilier/ville-de-montreal/petite-patrie/']},
    metro_jean_talon: {longitude: -73.6078056, latitude: 45.5369761, search_terms: ['/b-immobilier/ville-de-montreal/jean-talon/']},
  }

  # Supported states:
  # unjudged, rejected, retained

  def self.unjudged
    where("state = 'unjudged' OR state = 'retained'")
  end

end
