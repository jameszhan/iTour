
class Task < ActionController::Metal
  include ActionController::Rendering
  
  append_view_path "#{Rails.root}/app/views"
  
  def index
    site, type = params[:site], params[:type]
    if site && type
      begin
        Resque.enqueue(Crawler, site, type) 
        render :status => 200, :text => "OK"
      rescue Exception => e
        render :status => 400, :text => e
      end

    else
      @sites = YAML.load_file("#{Rails.root}/lib/sites.yaml")["SITES"]
      render :layout => "layouts/rack_common"
    end 
  end
  
end