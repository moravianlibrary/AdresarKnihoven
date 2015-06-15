class LibrariesController < ApplicationController
  before_action :set_library, only: [:edit, :update, :destroy]


  autocomplete :library, :name  


  # GET /libraries
  # GET /libraries.json
  def index
    @query = params[:q];
    @q = @query.downcase unless @query.nil?        
    @libraries = Library.search(@q, params[:page])
    if @libraries.count == 1 && request.format.html?
      redirect_to action: "show", id: @libraries[0].id
    end
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
     @library = Library.find(params[:id])
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
