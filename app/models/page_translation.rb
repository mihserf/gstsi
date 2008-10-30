class PageTranslation < ActiveRecord::Base
  belongs_to :localedb
  belongs_to :page
end
