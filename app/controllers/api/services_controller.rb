class Api::ServicesController < ApiController

   def index
    if params[:library_id]
      library = Library.find_by(sigla: params[:library_id].upcase)
      if(library.nil?) 
        render json: {error: "library not found"}, status: :not_found
      else
        @services = library.services
      end
    else
      @services = Service.all
    end   
  end

  def show
    @service = Service.find_by(code: params[:id])
    if(@service.nil?) 
      render json: {error: "service not found"}, status: :not_found
    end
  end

end
