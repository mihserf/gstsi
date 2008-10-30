class TrainingTranslation < ActiveRecord::Base
  belongs_to :localedb
  belongs_to :training
end
