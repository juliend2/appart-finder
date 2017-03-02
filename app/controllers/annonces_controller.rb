class AnnoncesController < ApplicationController
  def index
    @annonces = Annonce.unjudged
  end
end
