class AlbumTranslation < ActiveRecord::Base
  belongs_to :localedb
  belongs_to :album

    
end
