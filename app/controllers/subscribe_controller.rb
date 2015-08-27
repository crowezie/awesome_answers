class SubscribeController < ApplicationController

  def index

  end

  def create
    @name = params[:name]
    @email = params[:email]

    render :index, layout: "application"
    # render text: "Thank you for contacting us"
  end

end
