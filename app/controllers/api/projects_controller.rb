class Api::ProjectsController < ApiController

  def index
    if params[:library_id]
      library = Library.find_by(sigla: params[:library_id].upcase)
      if(library.nil?) 
        render json: {error: "library not found"}, status: :not_found
      else
        @projects = library.projects
      end
    else
      @projects = Project.all
    end   
  end

  def show
    @project = Project.find_by(code: params[:id])
    if(@project.nil?) 
      render json: {error: "project not found"}, status: :not_found
    end
  end

end
