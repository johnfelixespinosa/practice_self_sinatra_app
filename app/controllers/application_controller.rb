class ApplicationController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/signup' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    else
      redirect '/sessions/error'
    end
  end

  get '/sessions/error' do
    erb :'sessions/error'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

  get '/materials/new' do #loads create new recipe form
    erb :'/materials/new'
  end

  post '/calculate' do  #creates a materials object
    @materials = Materials.create(params)
    redirect to "/materials/#{@materials.id}"
  end

  get '/materials/:id' do  #loads show page
    @materials = Materials.find_by_id(params[:id])
    erb :'/materials/show'
  end

end
