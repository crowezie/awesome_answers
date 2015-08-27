class WelcomeController < ApplicationController

  # Setting the layout in here changes the default layout for all the actions in this controller.
  # layout "special"

  def index
    # Rails automatically renders a template with the views subfolder matching the controllers name. In this case the welcome folder. It will look for a file named index with the appropriate format and templating language so we can write the following, but it is redundant:
    # render :index, layout: "application"
    # only need it if you want to render something other than index or application
  end

  def hello
    @name = params[:name]
  end
end
