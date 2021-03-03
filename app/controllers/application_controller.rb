require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions
  use Rack::Flash


  get '/' do
    erb :index
  end

  patch '/songs/:slug/edit' do
    song = Song.find_by_slug(params[:slug])
    flash[:message] = "Successfully updated song."
    # binding.pry
    song.update(name: params[:song][:name])
    song.genres.clear
    if params[:song][:genres]
      params[:song][:genres].each do |g|
        genre = Genre.find_by(name: g)
        song.genres << genre
      end
    end
    song.artist = Artist.find_or_create_by(name: params[:song][:artist])
    song.save
    # binding.pry
    redirect :"/songs/#{song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :'songs/show'
  end


end
