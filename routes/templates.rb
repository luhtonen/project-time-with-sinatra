class ProjectTimeApp < Sinatra::Base

  get '/templates' do
    env['warden'].authenticate!
    activate_tab('templates')

    haml :templates
  end
end