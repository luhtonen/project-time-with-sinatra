class ProjectTimeApp < Sinatra::Base

  @active_tab = ''

  get '/' do
    activate_tab('')
    haml :index
  end

  def active_tab?(tabname)
    if @active_tab == tabname
      true
    else
      false
    end
  end

  def activate_tab(tabname)
    @active_tab = tabname
  end
end