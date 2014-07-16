class ProjectTimeApp < Sinatra::Base

  @show_inactive_projects = false

  def set_show_inactive_projects

  end

  before %r{/projects/*} do
    env['warden'].authenticate!
    activate_tab('projects')
  end

  before %r{/projects/(\d+)} do |id|
    @project = Project.get(id)

    if !@project
      flash[:error] = "Project #{id} was not found"
      # 404 # Not found
      redirect '/projects'
    elsif @project.user_id != env['warden'].user.id
      flash[:error] = "You're not authorized to see this page"
      # 403 # Not authorized
      redirect '/projects'
    end
  end

  get %r{projects/\d+} do
    if @project
      haml :project_details
    end
  end

  get '/projects/new' do
    haml :project_details
  end

  post '/projects' do
    id = params[:id]
    if id
      @project = Project.get(id)
    end
    params['active'] = params['active'] == 'on' ? true : false
    input = params.slice 'title', 'number', 'location', 'position', 'mandays', 'approver', 'active'
    if params['startdate']
      input['startdate'] = params['startdate']
    end
    if params['enddate']
      input['enddate'] = params['enddate']
    end
    if @project
      if @project.update(input)
        flash[:success] = "Project was saved successfully"
        #200 # OK
        redirect '/projects'
      else
        flash[:error] = "Was not able to update the project #{@project.title}"
        #400 # Bad request
        redirect '/projects'
      end
    else
      @project = Project.new(input)
      @project.user = env['warden'].user
      if @project.save()
        flash[:success] = "Project was saved successfully"
        # 200 # Ok
        redirect '/projects'
      else
        flash[:error] = "Was not able to create the project #{@project.title}"
        # 400 # Bad request
        redirect '/projects'
      end
    end
  end

  delete %r{projects/\d+} do
    if @project
      input['active'] = false
      if @project.update input
        flash[:success] = "Project was successfully deleted"
        # 200 # OK
        redirect '/projects'
      else
        flash[:error] = "Was not able to delete the project #{@project.title}"
        # 500 # Internal Server Error
        redirect '/projects'
      end
    end
  end

  get '/projects' do
    @projects = Project.all(:user => env['warden'].user, :active => true)
    haml :projects
  end
end