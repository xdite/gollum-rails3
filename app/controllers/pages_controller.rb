require 'gollum'
class PagesController < ApplicationController
 
  def page
    page_name = params[:page] || "Home"
    show_page_or_file(page_name)
  end
  
  def create
    name = params[:page]
    wiki = Gollum::Wiki.new("/Users/xdite/projects/personal_wiki")

    format = params[:format].intern

    begin
      wiki.write_page(name, format, params[:content], commit_message)
      redirect_to "/#{name}"
    rescue Gollum::DuplicatePageError => e
      @message = "Duplicate page: #{e.message}"
      render :error
    end
  end
  
  def history
    @name     = params[:name]
    wiki      = Gollum::Wiki.new("/Users/xdite/projects/personal_wiki")
    @page     = wiki.page(@name)
    @page_num = [params[:page].to_i, 1].max
    @versions = @page.versions :page => @page_num
  end
  
  def edit
    if request.post?
      name   = params[:name]
      wiki   = Gollum::Wiki.new("/Users/xdite/projects/personal_wiki")
      page   = wiki.page(name)
      format = params[:format].intern
      name   = params[:rename] if params[:rename]

      wiki.update_page(page, name, format, params[:content], commit_message)

      redirect_to "/#{Gollum::Page.cname name}"
    else
      @name = params[:name]
      wiki = Gollum::Wiki.new("/Users/xdite/projects/personal_wiki")
      if page = wiki.page(@name)
        @page = page
        @content = page.raw_data
      else
        render :create
      end
    end
  end
  
  protected
  
  
  def show_page_or_file(name)
    wiki = Gollum::Wiki.new("/Users/xdite/projects/personal_wiki")
    if page = wiki.page(name)
      @page = page
      @name = name
      @content = page.formatted_data
      render :page
    elsif file = wiki.file(name)
      content_type file.mime_type
      file.raw_data
    else
      @name = name
      render :create
    end
  end

  def commit_message
    { :message => params[:message] }
  end
  
end
