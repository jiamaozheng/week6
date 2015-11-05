class FlightsController < ApplicationController

  def share
    flight = Flight.find(params[:id])
    flight.share
    redirect_to flights_url, notice: "Message sent!"
  end

  def index
    if params[:date]
      date = Date.strptime(params[:date], "%m-%d-%Y")
    else
      date = Date.today
    end

    @flights = Flight.where('DATE(scheduled_at) = ?', date)
    @flights = @flights.order('scheduled_at asc').limit(100)

    respond_to do |format|
      format.html
      format.json do
        render json: @flights
      end
    end
  end

  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy
    respond_to do |format|
      format.html do
        redirect_to flights_url
      end
      format.js # do the default thing
    end

  end
end
