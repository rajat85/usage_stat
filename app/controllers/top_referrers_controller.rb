class TopReferrersController < ApplicationController

  def index
    top_referrers = PageVisit.top_referrers
    render json: top_referrers
  end

end
