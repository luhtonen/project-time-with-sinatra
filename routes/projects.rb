class ProjectTimeApp < Sinatra::Base

  get '/projects' do
    env['warden'].authenticate!
    activate_tab('projects')

    haml :projects
  end

  # get '/projects' do
  #   env['warden'].authenticate!
  #   @current_user = env['warden'].user
  #   haml :projects
  # end
end