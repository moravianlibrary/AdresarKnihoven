class LibrariesController < ApplicationController

  autocomplete :library, :name, limit:20, where:"active='t'"#,  :full => true

  # def get_autocomplete_items(parameters)
  # super(parameters).group(:name)
  # end

  def get_autocomplete_select_clause(model, method, options)
    "distinct #{method}"
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
        like_clause = (postgres?(model) ? 'ILIKE' : 'LIKE')
        @all = Library.where('LOWER(name) #{like_clause} ? OR LOWER(sigla) = ? OR LOWER(code) = ? OR LOWER(city) = ?', "%#{q}%", "#{q.delete(' ')}", "#{q}", "#{q}")
      end     
      @all = @all.where(active:true) if params[:inactive].nil?     
      if @all.count == 1 && request.format.html?
        redirect_to action: "show", id: @all[0].sigla
      end
    end
    @libraries = @all.order(:name).paginate(page: params[:page], per_page: 20)
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    @library = Library.find_by(sigla: params[:id].upcase)
    no_note = nil
    @library.websites.order(:id).each do |web|
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

    def postgres?(model)
      ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'postgresql'
    end

    def library_params
      params.require(:library).permit(:name, :code, :city, :street, :zip, :description, :longitude, :latitude, :email, :sigla, :district, :town, :url, :context, :phone)
    end
end
