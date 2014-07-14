class ProjectTimeApp < Sinatra::Base

  before %r{/timereport/*} do
    env['warden'].authenticate!
    activate_tab('timereport')
  end

  before %r{/timereport/(\d+)} do |proj_id|
    @project = Project.get(proj_id)

    if !@project
      flash[:error] = "Project #{proj_id} was not found"
      # 404 # Not found
      redirect '/projects'
    elsif @project.user_id != env['warden'].user.id
      flash[:error] = "You're not authorized to see this page"
      # 403 # Not authorized
      redirect '/projects'
    else
      @dayentries = Dayentry.all(:project_id => proj_id)
    end
  end

  get %r{timereport/\d+} do
    if @project
      haml :timereport
    end
  end

  get '/timereport' do
    @dayentries = Dayentry.all(:user_id => env['warden'].user.id)

    haml :timereport
  end
end