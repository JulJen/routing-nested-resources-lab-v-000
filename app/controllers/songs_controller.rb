class SongsController < ApplicationController


  def index
  if params[:artist_id]
    @artist = Artist.find_by(id: params[:artist_id])
    if @artist.nil?
      redirect_to artists_path, alert: "Artist not found"
    else
      @songs = @artist.songs
    end
  else
    @songs = Song.all
  end
end

def show
  if params[:artist_id]
    @artist = Artist.find_by(id: params[:artist_id])
    @song = @artist.songs.find_by(id: params[:id])
    if @song.nil?
      redirect_to artist_songs_path(@artist), alert: "Song not found"
    end
  else
    @song = Song.find(params[:id])
  end
end


#   # it "redirects to artists songs when artist song not found" do
#   #   get :show, id: 12345, artist_id: @artist.id
#   #   expect(controller).to set_flash[:alert]
#   #   expect(response).to redirect_to artist_songs_path(@artist)
#   # end
#
#   def index
#     if params[:artist_id]
#       @artist = Artist.find_by(id: params[:artist_id])
#       if @artist.nil?
#         # flash[:alert] = "Artist not found."
#         redirect_to artists_path
#       else
#         # @songs = Song.where("artist_id=?", params[:artist_id])
#         @songs = @artist.songs
#       end
#     else
#       @songs = Song.all
#     end
#   end
#
#
# #   def show
# #     if params[:artist_id]
# #       @artist = Artist.find_by(id: params[:artist_id])
# #       @song = @artist.songs.find_by(id: params[:id])
# # # binding.pry
# #       # if @song.nil?
# #       # if Song.find_by(id: params[:id]).nil?
# #       #   flash[:alert] = "Song not found."
# #       #   redirect_to artist_songs_path(params[:artist_id])
# #       if params[:artist_id] && Song.find_by(id: params[:id]).nil?
# #         flash[:alert] = "Song not found."
# #         redirect_to artist_songs_path(params[:artist_id])
# #       end
# #     else
# #       @song = Song.find(params[:id])
# #     end
# #   end
#
#   def show
#     if params[:artist_id] && Song.find_by(id: params[:id]).nil?
#       flash[:alert] = "Song not found."
#       redirect_to artist_songs_path(params[:artist_id])
#     else
#       @song = Song.find(params[:id])
#     end
#   end


  def new
    @song = Song.new
  end


  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
