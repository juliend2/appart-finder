class AnnoncesController < ApplicationController
  def index
    @annonces = Annonce.unjudged
  end

  def set_state
    @annonce = Annonce.find(params[:id])
    @annonce.state = params[:state]
    @annonce.save
    redirect_to root_url
  end
end
