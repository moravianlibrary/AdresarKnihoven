class LibrariesController < ApplicationController
  before_action :set_library, only: [:edit, :update, :destroy]


  autocomplete :library, :name  


  # GET /libraries
  # GET /libraries.json
  def index
    @query = params[:q];
    @q = @query.downcase unless @query.nil?        
    if params[:lon] && params[:lat]
      @all = Library.where("ABS(latitude - #{params[:lat]}) < 0.02 AND ABS(longitude - #{params[:lon]}) < 0.02")
    else
      @all = Library.where('LOWER(name) LIKE ? OR LOWER(sigla) = ? OR LOWER(code) = ? OR LOWER(city) = ?', "%#{@q}%", "#{@q}", "#{@q}", "#{@q}")
      if @all.count == 1 && request.format.html?
        redirect_to action: "show", id: @all[0].sigla
      end
    end
    @libraries = @all.paginate(page: params[:page], per_page: 20)
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

  def sigla    
    @library = Library.where(:sigla => params[:sigla].upcase).first    
    respond_to do |format|
      if @library.nil?
        format.json { render json: {}, status: :unprocessable_entity }
      else
        format.json 
      end
    end
  end  

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: 'Library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:name, :code, :city, :street, :zip, :description, :longitude, :latitude, :email, :sigla, :district, :town, :url, :context, :phone)
    end
end
