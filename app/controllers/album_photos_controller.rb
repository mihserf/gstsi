class AlbumPhotosController < ApplicationController
  def destroy
    @photo=AlbumPhoto.find(params[:id])
    @photo.destroy

    respond_to  do |format|
      format.js { render :xml => "destroied" }
    end
  end
end
