class Pages::Edit < Mustache::Rails
  include Editable
  attr_reader :page, :content

  def title
    "Editing #{@page.title}"
  end
  
end