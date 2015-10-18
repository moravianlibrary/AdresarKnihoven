class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order(date: :asc).paginate(page: params[:page], per_page: 5)
  end

  def show    
  end

  def edit
  end  

  def new
    @event = Event.new
    @event.date = Date.today
  end

  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url, notice: 'Akce byla vytvořena.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_url, notice: 'Akce byla upravena.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Akce byla odstraněna.' }
      format.json { head :no_content }
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