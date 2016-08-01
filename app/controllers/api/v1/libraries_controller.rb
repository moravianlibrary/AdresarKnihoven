class Api::V1::LibrariesController < ApiController

  def index
    q = params[:q];
    q = q.downcase unless q.nil?
    params[:status] ||= "active"
    params[:limit] ||= 20
    params[:offset] ||= 0
    params[:sort] ||= "priority"
    result = Library.all
    if !q.nil?    
      result = result.where("LOWER(libraries.name) #{like_clause} ? OR LOWER(sigla) = ? OR LOWER(libraries.code) = ? OR LOWER(city) #{like_clause} ?", "%#{q}%", "#{q.delete(' ')}", "#{q}", "#{q}%")
    end     
    if params[:status] == "active"
      result = result.where(active:true)
    elsif params[:status] == "inactive"
      result = result.where(active:false)
    end
    @count = result.count
    result = result.select(select_clause(params[:lat], params[:lon]))
    

    #@libraries = all.order(:priority, :name).offset(params[:offset]).limit(params[:limit])  

    #query = "SELECT * FROM libraries"# LIMIT #{params[:limit]} OFFSET #{params[:offset]}"
    #@libraries = Library.connection.execute(query)
    #@libraries = Library.find_by_sql(query)
    #@libraries = Library.select("")

    if params[:sort] == "name"
      result = result.order(:name, :priority)
    elsif params[:sort] == "distance" && params[:lon] && params[:lat]
      result = result.order("distance", :priority, :name)
    else 
      result = result.order(:priority, :name)
    end
    result = result.order(:priority, :name)


    @libraries = result.offset(params[:offset]).limit(params[:limit])  
    @limit = params[:limit]
    @offset = params[:offset]
  end


  def markers
    q = params[:q];
    q = q.downcase unless q.nil?
    params[:status] ||= "active"
    if q.nil?
      all = Library.all
    else        
      all = Library.where("LOWER(libraries.name) #{like_clause} ? OR LOWER(sigla) = ? OR LOWER(libraries.code) = ? OR LOWER(city) #{like_clause} ?", "%#{q}%", "#{q.delete(' ')}", "#{q}", "#{q}%")
    end     
    all = all.where(active:true).where("latitude IS NOT NULL AND longitude IS NOT NULL")
    @libraries = all
    @lang = params[:lang]
  end


  def show
    @library = Library.find_by(sigla: params[:id].upcase)
    if(@library.nil?) 
      render json: {error: "library not found"}, status: :not_found
    end
  end

  def autocomplete
    q = params[:q];
    q = q.downcase unless q.nil?
    params[:limit] ||= 15
    if params[:lang] == "en"
      search_field = "name_en"
    else
      search_field = "name"
    end
    if q.nil?
      all = Library.all
    else        
      all = Library.where("LOWER(libraries.#{search_field}) #{like_clause} ?", "#{q}%")
    end     
    all = all.where(active:true)
    @list = all.order(search_field).select(search_field).uniq.limit(params[:limit]).pluck(search_field)
  end



 
  private
    def postgres?
      ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'postgresql'
    end

    def like_clause
      if postgres?
        'ILIKE'
      else 
        'LIKE'
      end
    end
    #lat = 49.20865
    #lon = 16.59402778
    def select_clause(lat, lon)
      if postgres? && lat && lon
        "*, (2 * 3961 * asin(sqrt((sin(radians((latitude - #{lat}) / 2))) ^ 2 + cos(radians(#{lat})) * cos(radians(latitude)) * (sin(radians((longitude - #{lon}) / 2))) ^ 2))) as distance"
      else
        '*, null as distance'
      end
    end
end
