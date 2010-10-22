class Pages::Create < Mustache::Rails
    include Editable

    attr_reader :page, :name

    def title
      "Create a new page"
    end

    def page_name
      @name.gsub('-', ' ')
    end

    def formats
      super(:markdown)
    end
end