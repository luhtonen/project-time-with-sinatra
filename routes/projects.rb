class ProjectTimeApp < Sinatra::Base

  before %r{/projects/*} do
    env['warden'].authenticate!
    activate_tab('projects')
  end

  before %r{/projects/(\d+)} do |id|
    @project = Project.get(id)

    if !@project
      halt 404, "project #{id} not found"
    end
  end

  get %r{projects/\d+} do
    if @project
      @project
      haml :project_details
    end
  end

  get '/projects/new' do
    haml :project_details
  end

  post '/projects' do
    input = params.slice 'title', 'description'
    if @project
      if @project.update(input.only 'title', 'description')
        200 # OK
      else
        400 # Bad request
      end
    else
      if @project.save()
        200 # Ok
      else
        400 # Bad request
      end
    end
  end

  delete %r{projects/\d+} do
    if @project
      @project.active = false
      if @project.update('active')
        200 # OK
      else
        500 # Internal Server Error
      end
    end
  end

  get '/projects' do
    @projects = Project.all
    haml :projects
  end

  # get '/projects' do
  #   env['warden'].authenticate!
  #   @current_user = env['warden'].user
  #   haml :projects
  # end
end