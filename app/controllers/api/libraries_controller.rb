class Api::LibrariesController < ApiController

  def index
    q = params[:q];
    q = q.downcase unless q.nil?
    params[:status] ||= "active"
    params[:limit] ||= 20
    params[:offset] ||= 0
    if q.nil?
      all = Library.all
    else        
      all = Library.where("LOWER(libraries.name) #{like_clause} ? OR LOWER(sigla) = ? OR LOWER(libraries.code) = ? OR LOWER(city) #{like_clause} ?", "%#{q}%", "#{q.delete(' ')}", "#{q}", "#{q}%")
    end     
    if params[:status] == "active"
      all = all.where(active:true)
    elsif params[:status] == "inactive"
      all = all.where(active:false)
    end
    @libraries = all.order(:priority, :name).offset(params[:offset]).limit(params[:limit])      
  end


  def show
    @library = Library.find_by(sigla: params[:id].upcase)
    if(@library.nil?) 
      render json: {error: "library not found"}, status: :not_found
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
end