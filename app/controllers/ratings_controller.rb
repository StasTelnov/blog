class RatingsController < ApplicationController

  def create
    render RatingCreateService.new(request).process.result
  end

end
