# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  around_filter :set_locale
  helper :all # include all helpers, all the time
  

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '90f95eccdeeaeef2745fda63a939dad0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  
  private

  def admin_required
    if session[:admin]
      return true
    else
      admin_login
    end
  end

  def admin?
    session[:admin]
  end

  def admin_login
    redirect_to admin_login_path
  end

  def managing_translations(obj)
    params[:translations] ||= []
    if obj.new_record?
      obj.translations.build(params[:translations])
    else
      obj.translations.update(params[:translations].keys,params[:translations].values) unless params[:translations].empty?
    end
    
  end


  # Set the locale from the parameters, the session, or the navigator
  # If none of these works, the Globalite default locale is set (en-*)
  def set_locale
    # Get the current path and request method (useful in the layout for changing the language)
    @current_path = request.env['PATH_INFO']
    @request_method = request.env['REQUEST_METHOD']

    # Try to get the locale from the parameters, from the session, and then from the navigator
    if params[:lang]
      case params[:lang]
      when 'en'
	params_locale_code = 'en-*'
      when 'ru'
        params_locale_code = 'ru-RU'
      when 'ua'
        params_locale_code = 'ua-UA'
      end
    else
      params_locale_code = 'ru-RU' unless (request.method == :post) || (request.method == :put) || (request.method == :delete)
    end


    if params_locale_code
        logger.debug "[globalite] #{params_locale_code} locale passed"
        Locale.code = params_locale_code #get_matching_ui_locale(plocale_code) #|| session[:locale] || get_valid_lang_from_accept_header || Globalite.default_language
        #Localedb.global= params_locale_code
        # Store the locale in the session
        session[:lang] = Locale.code
    elsif session[:lang]
        logger.debug "[globalite] loading locale: #{session[:lang]} from session"
        Locale.code = session[:lang]
        #Localedb.global = session[:lang]
    else
        logger.debug "[globalite] found a valid http header locale: #{get_valid_lang_from_accept_header}"
        Locale.code = get_valid_lang_from_accept_header
        #Localedb.global = get_valid_lang_from_accept_header
    end
    @lang=Locale.code #@lang used in controllers and views
    Localedb.global=Locale.code.to_s
    logger.debug "[globalite] Locale set to #{Locale.code}"
    # render the page
    yield

    # reset the locale to its default value
    Locale.reset!
  end

  # Get a sorted array of the navigator languages
  def get_sorted_langs_from_accept_header
    accept_langs = (request.env['HTTP_ACCEPT_LANGUAGE'] || "en-us,en;q=0.5").split(/,/) rescue nil
    #return nil unless accept_langs
    return "ru-RU" unless accept_langs

    # Extract langs and sort by weight
    # Example HTTP_ACCEPT_LANGUAGE: "en-au,en-gb;q=0.8,en;q=0.5,ja;q=0.3"
    wl = {}
    accept_langs.each {|accept_lang|
        if (accept_lang + ';q=1') =~ /^(.+?);q=([^;]+).*/
            wl[($2.to_f rescue -1.0)]= $1
        end
    }
    logger.debug "[globalite] client accepted locales: #{wl.sort{|a,b| b[0] <=> a[0] }.map{|a| a[1] }.to_sentence}"
    sorted_langs = wl.sort{|a,b| b[0] <=> a[0] }.map{|a| a[1] }
  end

  # Returns a valid language that best suits the HTTP_ACCEPT_LANGUAGE request header.
  # If no valid language can be deduced, then <tt>nil</tt> is returned.
  def get_valid_lang_from_accept_header
    # Get the sorted navigator languages and find the first one that matches our available languages
    get_sorted_langs_from_accept_header.detect{|l| get_matching_ui_locale(l) }
  end

  # Returns the UI locale that best matches with the parameter
  # or nil if not found
  def get_matching_ui_locale(locale)
    lang = locale[0,2].downcase
    if locale[3,5]
      country = locale[3,5].upcase
      logger.debug "[globalite] trying to match locale: #{lang}-#{country}"
      locale_code = "#{lang}-#{country}".to_sym
    else
      logger.debug "[globalite] trying to match #{lang}-*"
      locale_code = "#{lang}-*".to_sym
    end

    # Check with exact matching
    if Globalite.ui_locales.values.include?(locale)
      logger.debug "[globalite] Globalite does include #{locale}"
      locale_code
    end

    # Check on the language only
    Globalite.ui_locales.values.each do |value|
      value.to_s =~ /#{lang}-*/ ? value : nil
    end
  end
  
end
