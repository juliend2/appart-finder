class Annonce < ActiveRecord::Base
  validates_uniqueness_of :url

  # Supported states:
  # unjudged, rejected, retained

  def self.unjudged
    where("state = 'unjudged' OR state = 'retained'")
  end

end
