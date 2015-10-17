class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url, notice: 'Akce byla vytvořena' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    def set_event
    	@event = Event.find(params[:id])
	  end

	  def event_params
	  	params.require(:event).permit(:title, :description, :url, :date, :place)
	  end
	  
end