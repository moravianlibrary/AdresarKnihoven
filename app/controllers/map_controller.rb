class MapController < ApplicationController
  def index
     @libraries = Library.all
  end
end
