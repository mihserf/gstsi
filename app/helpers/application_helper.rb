# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def admin?
    session[:admin]
  end

  def menu_countries
    menu_countries_items=""
    countries = Country.find(:all, :order => :num_order)
    for country in countries do
	    menu_countries_items<< "<li>"
            menu_countries_items<< link_to(country.name, lang_country_path(lang_id(@lang),country.ident_name))
            menu_countries_items<< "</li>"
    end
    "<ul>"+menu_countries_items+"</ul>" unless menu_countries_items==""
  end

  def lang_id(lang)
    case lang.to_s
      when 'en-*'
        return "en"
      when 'ru-RU'
        return "ru"
      when 'ua-UA'
        return "ua"
      else return ""
     end
  end

  def countries_list(country)
    countries = Country.find(:all)
    render :partial => "shared/countries_list", :locals => {:countries => countries, :current_country => country}
  end

  #def items_list(obj, attr_name, order)
  def items_list(obj, *options)
    options =options.extract_options!


    attr_name = (options[:attr_name])?   options[:attr_name] : "name"
    order = (options[:order])?  options[:order] : nil
    parent_obj = (options[:belongs_to])?  options[:belongs_to] : nil
    if obj.class==Array
      items = obj
      item = nil
    else
      if parent_obj
        items = parent_obj.send("#{obj.class.to_s.tableize}").find(:all, :order =>order)
      else
        items = obj.class.find(:all, :order =>order)
      end
      item = obj
    end
    render :partial => "shared/items_list", :locals => {:items => items, :current_item => item, :attr_name => attr_name, :parent_obj => parent_obj}
  end

  def tabs(*args)
    options=args.extract_options!
    i=0
    ul=""
    li=""
    
    options = options.to_a.sort_by{|k| k.to_s}
    options.each do |key,val|
      i+=1
      li_val=options.size==1? "<li id='but#{i}' class='but but#{i}'><a href='#' id='link_to_page_#{i}'><span>GST</span></a></li>" : "<li id='but#{i}' class='but but#{i}'><a href='#page-#{i}' id='link_to_page_#{i}'><span>#{val}</span></a></li>"
      li<<li_val
    end
     ul="<ul>"+li+"</ul>"
     render :partial => "shared/tabs", :locals => {:ul => ul}
  end

  def lang_choice
    #langs = obj.class.find(:all, :select => :lang, :conditions =>{:ident_name => obj.ident_name}).collect(&:lang) rescue []  # if obj hasn't any of this attributes then rescue with empty array
    langs = Localedb.find(:all).collect(&:short);
    render  :partial  =>  "shared/lang_choice", :locals => {:langs => langs}
  end

  def ident_choice(obj)
     render :partial => "shared/ident_choice", :locals => {:obj => obj, :obj_name => obj.class.to_s.tableize.singularize}
  end

  def add_link(name, container)
  link_to_function name do |page|
    page.insert_html :bottom, container.to_sym, :partial => container.singularize, :object => container.classify.constantize.new
    page << 'initiateDatepicker();' if name=='Добавить дату'
  end
  end

  def static_page(objs)
    page=Page.find(:first, :conditions => {:controller_name => objs.first.class.to_s.tableize})
    unless page.nil?
      render  :partial => "shared/static_page", :locals => {:page => page}
    end
  end

  def set_order(obj, *options)
    options =options.extract_options!.reverse_merge!(:attr_name => "name")

    render :partial => "shared/set_order", :locals => {:obj => obj, :attr_name => options[:attr_name]}
  end

  def time_table(member)
    beginning_of_current_month = Date.today().beginning_of_month
    beginning_of_2_months_ago = Date.today().months_ago(2)
    date_cond = admin? ?  beginning_of_2_months_ago : beginning_of_current_month
    member_events = member.member_events.find(:all, :include => :member_event_dates, :order =>"member_event_dates.begin_date ASC", :conditions => "member_event_dates.begin_date >= '#{date_cond}'")
    render :partial=>"shared/time_table", :locals => {:member_events => member_events}
  end
  
  
  #CONTROLLER HELPERS

  def update_numbers(model, params, new_obj_id=nil)
    #depends on helper set_order
    if params[:sortable_ids]
      albums = model.find(:all, :order => 'number DESC', :limit => 20)
      if new_obj_id
        params[:sortable_ids] = params[:sortable_ids].gsub(/new/,new_obj_id.to_s)
      end
      sortable_ids = params[:sortable_ids].split(',')
      i=albums.size+1
      sortable_ids =Hash[*sortable_ids.collect {|v| i-=1; [v,{'number'=>i}]}.flatten]
        model.update(sortable_ids.keys, sortable_ids.values)
    end
  end

end
