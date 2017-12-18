class TopUrlsController < ApplicationController

  def index
    top_urls = PageVisit.top_urls
    render json: top_urls
  end

end
