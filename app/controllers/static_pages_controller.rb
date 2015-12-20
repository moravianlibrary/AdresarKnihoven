class StaticPagesController < ApplicationController
  def home
  	@count = Library.where(active:true).count;
  	@events = Event.where("date >= ?", Date.today).order(date: :asc).limit(7)
  end

  def about
  
  end



end
