class SongsController < ApplicationController



    get '/songs/new' do
      # binding.pry
      @genres = Genre.all
      erb :'songs/new'
    end

    post '/songs' do
      song = Song.create(name: params[:name])
      song.artist = Artist.find_or_create_by(name: params[:artist][:name])
      # binding.pry
      params[:genre][:name].each do |genre|
        song.genres << Genre.find_by(name: genre)
      end
      song.save
      flash[:message] = "Successfully created song."
      redirect :"/songs/#{song.slug}"
    end

    get '/songs' do
      @songs = Song.all
      erb :'songs/index'
    end

    get '/songs/:slug' do
      @song = Song.find_by_slug(params[:slug])
      # binding.pry
      erb :'songs/show'
    end

    get '/songs/:slug/edit' do
      @song = Song.find_by_slug(params[:slug])
      @genres = Genre.all
      # binding.pry
      erb :'songs/edit'
    end



end
