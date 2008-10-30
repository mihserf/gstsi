class Localedb < GstDb
  @@global_locale = nil

   def self.global
     @@global_locale
   end

   def self.global=( locale )
     if locale.is_a? Localedb
       @@global_locale = locale
     elsif locale.is_a? String
       locale = Localedb.find(:first, :conditions => ['short = ? OR code = ?', locale, locale])
       return false if (! locale)
       @@global_locale = locale
     else
       # empty
       @@global_locale = nil
     end
   end

   def master?
     self.master == true
   end

end
