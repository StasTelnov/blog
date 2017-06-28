class RatingsController < ApplicationController

  def create
    service = RatingCreateService.new(request).process

    if service.success?
      render json: service.result
    else
      render json: service.result, status: 422
    end
  end

end
