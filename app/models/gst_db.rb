class GstDb< ActiveRecord::Base
  self.abstract_class = true
  establish_connection("gst_db_#{RAILS_ENV}".to_sym)
end
