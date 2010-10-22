class Pages::Page < Mustache::Rails
  attr_reader :content, :page, :footer

  def title
    @page.title
  end

  def format
    @page.format.to_s
  end

  def author
    @page.version.author.name
  end

  def date
    @page.version.authored_date.strftime("%Y-%m-%d %H:%M:%S")
  end

  def has_footer
    @footer ||= @page.footer
    !@footer.nil?
  end

  def footer_content
    @footer ||= @page.footer
    @footer.formatted_data
  end

  def footer_format
    @footer ||= @page.footer
    @footer.format.to_s
  end
end