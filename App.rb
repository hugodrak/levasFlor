class App < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  # vet ej
  set :show_exceptions, :after_handler

  before do
    path = request.path_info
    # verify if user want to go to edit mode but arent allowed
    if path[0..7] == '/editor/' && session[:editor] == nil
      unless path == '/editor/login' || path == '/editor/resetpassword'
        # flash[:fail] = "Forbidden path!"
        # flash[:uri] = "/"
        p 'här'
        redirect '/editor'
      end
    end

    pl = request.path_info.length
    #here we got at defined lang path
    if session[:lang] == nil && pl > 1 && pl < 3
      session[:lang] = request.path_info[1..3]
      # here we dont have so setting it to en
    elsif session[:lang] == nil
      session[:lang] = 'en'
    end
  end

  #this get sets session language if path contains lang
  get '/:lang' do

    pass unless params['lang'].length <= 2
    session[:lang] = params[:lang]

    slim :"#{params[:lang]}/index"
  end

  # about
  get '/:lang/about' do
    slim :"#{params[:lang]}/about"

  end

  # products
  get '/:lang/products' do

    @products = Products.all(lang: session[:lang])

    slim :"#{params[:lang]}/products"
  end

  # wood info page with table
  get '/:lang/woods/:id' do

    slim :"#{params[:lang]}/wood"
  end

  #all woods
  get '/:lang/woods' do

    @woods = Woods.all(lang: session[:lang])

    slim :"#{params[:lang]}/woods"
  end


  # default path but rediret to /lang
  get '/' do
    redirect '/' + session[:lang]
  end

  get '/en' do
    redirect '/' + session[:lang]
  end

  # these four are enabling nav to be genereal ie getting lang from session
  get '/woods' do
    redirect '/' + session[:lang] + '/woods'
  end

  get '/about' do
    redirect '/' + session[:lang] + '/about'
  end

  get '/products' do
    redirect '/' + session[:lang] + '/products'
  end
  ##############


  #enabling multiple comparison for specific wood page
  post '/woodselect' do
    wood = Woods.all(:id => params[:selectedWood].to_i)[0]
    properties = WoodLabels.all

    resp = []

    properties.each do |prop|
      resp << wood.send(prop.alias).to_s + " " + prop.suffix.to_s
    end

    return resp.to_json
  end


  # controlls if editor is verified and logs into editor interface
  get '/editor' do

    if session[:editor] == nil
      slim :"editor/login", :layout => :"editor/layout"
    else
      slim :"editor/home", :layout => :"editor/layout"
    end

  end

  #login verification for editor
  post '/editor/login' do
    editor = Editors.first(:username => params[:username])
    if editor.password == params[:password]
      session[:editor] = editor.id
      editor.update(:last_login => Time.now)
      redirect '/editor/home'
    else
      flash[:fail] = "The username or password does not exist."
      flash[:uri] = "/editor"
      redirect '/failure'
    end

  end

  # start page for editor
  get '/editor/home' do
    @wood = Woods.all()
    slim :"editor/home", :layout => :"editor/layout"

  end

  # update slimfiles with editor mode
  post '/editor/textupdate' do
    begin
      fh = File.open('./views/en/index.slim', 'w')
      fh.print params[:text]
      fh.close
      return 'Page saved and updated!'
    rescue
      return 'Page could not be saved :('
    end
  end

  # return woods to select
  post '/editor/woodselect' do
    if params[:selectedWood] == 'new'
      @wood = Woods.create(:created_at => Time.now, :created_by => session[:editor].to_i)
    else
      @wood = Woods.first(:id => params[:selectedWood])
    end
    p @wood
    return @wood.to_json
  end

  # update wood info, create fixed mapping to avoid creation date.
  # post '/editor/woodsss' do
  #   params.delete('captures')
  #
  #   wood = Woods.first(:id => params[:id])
  #   p wood
  #   # byebug
  #   p params
  #   #does not update, because items in the params match existing in db -- fix this
  #   p wood.update(params.to_h)
  #
  #   #wood.updated_at = Time.now
  #   #wood.updated_by = session[:editor].to_i
  #
  #   return 'updated!'
  #
  # end
  #
  post '/editor/resetpassword' do
    p params[:username]

    unless params[:username] == ''
      user = Editors.first(:username => params[:username])
      p user.update(:password => (0...8).map { (65 + rand(26)).chr }.join)

      Pony.options = {
          :subject => "Password reset LevasFlor",
          :body => "This is the body.",
          :via => :smtp,
          :via_options => {
              :address              => 'smtp.gmail.com',
              :port                 => '587',
              :enable_starttls_auto => true,
              :user_name            => 'noreply@cdubs-awesome-domain.com',
              :password             => ENV["SMTP_PASSWORD"],
              :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
              :domain               => "localhost.localdomain"
          }
      }
      Pony.mail(:to => user.email)
    end
    redirect '/'
  end

  # destroys session and logs out
  post '/editor/logout' do
    session.destroy
    puts 'session destroyed'
    redirect '/editor'
  end

  # fail page
  get '/failure' do
    @fail_msg = flash[:fail]
    @uri = flash[:uri]
    slim :failure, :layout => false
  end



  # error Errno::ENOENT do
  #   'So what happened was...' + env['sinatra.error'].message
  # end

end
