class CityTranslation < ActiveRecord::Base
  belongs_to :localedb
  belongs_to :city
end
