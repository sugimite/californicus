module ApplicationHelper
    def document_title
        if @title.present?
            "#{@title} - 学進会"
        else
            "学進会"
        end
    end
end
