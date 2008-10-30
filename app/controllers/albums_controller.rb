class AlbumsController < ApplicationController
  def index
    @albums = Album.find(:all)

    respond_to do |format|
      format.html { render :template => "albums/list" unless admin?}
      format.xml  { render :xml => @albums }
    end
  end

  def show
    @album = Album.find_by_ident_name(params[:id]) || Album.find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    Album.update_all( :main => false)
    @album = Album.find(params[:id])
    @album.attributes = params[:album]
    ApplicationController.helpers.update_numbers(@album.class, params)
    managing_photos

    respond_to do |format|
      if @album.save!
        flash[:notice] = 'Проект изменён.'
        format.html { redirect_to albums_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    managing_photos

    respond_to do |format|
      if (@album.save &&  ApplicationController.helpers.update_numbers(@album.class, params, @album.id))
        flash[:notice] = 'Альбом добавлен.'
        format.html { redirect_to albums_path }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end

  def managing_photos
    params[:photos] ||= []
    params[:photos].each do |photo|
      @album.album_photos.build(photo) unless photo[:uploaded_data] == ""
    end

    params[:existing_photos] ||= []
    params[:existing_photos].each_value do |photo|
      @photo = AlbumPhoto.find(photo[:id])
      @photo.update_attributes(photo)
    end unless params[:existing_photos].empty?
  end

  

end
