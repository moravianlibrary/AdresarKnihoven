class StaticPagesController < ApplicationController
  def home
  	@count = Library.count;
  	@events = Event.where("date >= ?", Date.today).order(date: :asc).limit(7)
  end

  def about
  
  end

end
