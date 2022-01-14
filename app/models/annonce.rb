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

  class And
    def initialize(token)
      @token = token
    end
  end

  def size
    self.class.size(title)
  end

  def self.size(title)
    tokens = title.split(/\s/)
    tokens.map! do |token|
      if token =~ /^[0-9]+$/
        # Integer
        token.to_i
      elsif (true if Float(token) rescue false)
        # Float
        token.to_f
      else
        # String
        case token
        when '1/2', '½', /demie?/ then 0.5
        when 'et', '&' then And.new(token)
        when /(\d+)½$/ then $1.to_i + 0.5
        else
          token
        end
      end
    end

    # pp tokens

    case tokens
    in [*, Integer => int, Float => float, *]
      int + float
    in [*, Integer => int, And, Float => float, *]
      int + float
    in [*, Float => float, *]
      float
    else
      tokens
    end
  end

end
