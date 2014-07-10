class ProjectTimeApp < Sinatra::Base

  get '/timereport' do
    env['warden'].authenticate!
    activate_tab('timereport')

    haml :timereport
  end
end