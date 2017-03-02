class Annonce < ActiveRecord::Base
  validates_uniqueness_of :url

  def self.unjudged
    where(state: 'unjudged').all
  end

end
