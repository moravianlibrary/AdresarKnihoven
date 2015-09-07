class StaticPagesController < ApplicationController
  def home
  	@count = Library.count;
  end

  def about
  
  end

end
