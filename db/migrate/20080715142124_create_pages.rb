class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :ident_name
      t.string  :name
      t.text  :content
      t.string :controller_name

      t.timestamps
    end

    Page.create!( :ident_name  => "home", :name =>"Главная")
        
    Page.create!( :ident_name  => "contacts", :name =>"Контакты")

    Page.create!(:ident_name  => "about_us", :name =>"О компании")

    Page.create!( :ident_name  => "faq", :name =>"FAQ")

    Page.create!( :ident_name  => "charity", :controller_name =>"charities", :name =>"Благотворительность")

    Page.create!( :ident_name  => "founder", :name =>"Основатель")

    Page.create!( :ident_name  => "team", :name =>"Команда")

    Page.create!( :ident_name  => "mission", :name =>"Задачи")

    Page.create!( :ident_name  => "principles", :name =>"Принципы работы")
    
  end

  def self.down
    drop_table :pages
  end
end
