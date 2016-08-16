module Universal
  module FlagsHelper

    #custom helper to use the flags system for starring items
    def star(doc)
      html = []
      html.push("<a href=\"javascript:void(0);\" onclick=\"$.post('/hn/flags', {'document[type]': '#{doc.class.to_s}', 'document[id]': '#{doc.id.to_s}'});\">")
      icon_id = "star_#{doc.class.to_s.parameterize}_#{doc.id.to_s}"
      if !doc.flagged_with?(:starred)
        html << "<i class=\"fa fa-star-o\" id=\"#{icon_id}\"></i>"
      else
        html << "<i class=\"fa fa-star\" id=\"#{icon_id}\"></i>"
      end
      html.push("</a>")
      return html.join('').html_safe
    end

  end
end