class LibrariesController < ApplicationController

  def autocomplete
    q = params[:q] || ""
    limit = params[:limit] || 20
    @all = Library.distinct.where("LOWER(name) #{like_clause} ? AND active='t'", "#{q}%").limit(limit).pluck(:name)
    render json: @all
  end 

  # GET /libraries
  # GET /libraries.json
  def index
    @show_results = params.has_key?(:q) || (params.has_key?(:lon) && params.has_key?(:lat))
    @query = params[:q];
    q = @query.downcase unless @query.nil?        
    if params[:lon] && params[:lat]
      @all = Library.where("ABS(latitude - #{params[:lat]}) < 0.02 AND ABS(longitude - #{params[:lon]}) < 0.02")
      @all = @all.where(active:true) if params[:inactive].nil?  
    else
      if @query.nil?
        @all = Library.all
      else        
        @all = Library.where("LOWER(name) #{like_clause} ? OR LOWER(sigla) = ? OR LOWER(code) = ? OR LOWER(city) #{like_clause} ?", "%#{q}%", "#{q.delete(' ')}", "#{q}", "#{q}%")
      end     
      @all = @all.where(active:true) if params[:inactive].nil?     
      if @all.count == 1 && request.format.html?
        redirect_to action: "show", id: @all[0].sigla
      end
    end
    if @show_results
      @libraries = @all.order(:name).paginate(page: params[:page], per_page: 20)   
    end
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    @library = Library.find_by(sigla: params[:id].upcase)
    no_note = nil
    @library.websites.each do |web|
      if web.note.nil?
        no_note = web.url unless no_note
      elsif web.note.downcase == 'web' || web.note.downcase == 'knihovna'
        @web = web.url
      elsif web.note.downcase == 'online katalog' || web.note.downcase == 'on-line katalog' || web.note.downcase == 'katalog'
        @catalog = web.url
      end        
    end
    if @web.nil? && no_note
      @web = no_note
    end

  end

 
  private
    def like_clause
      if ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'postgresql'
        'ILIKE'
      else 
        'LIKE'
      end
    end

    def library_params
      params.require(:library).permit(:name, :code, :city, :street, :zip, :description, :longitude, :latitude, :email, :sigla, :district, :town, :url, :context, :phone)
    end
end
