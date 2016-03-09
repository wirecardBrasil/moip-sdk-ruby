module Moip2
  class QueryParams

    attr_accessor :uri, :params, :query

    def initialize
      self.params = []
    end

    def full_text_search query
      self.query = "q=#{query}"
    end

    def equal key, value
      if value.kind_of?(Array)
        self.params.push("#{key}::in(#{value.join(",")})")
      else
        self.params.push("#{key}::eq(#{value})")
      end
    end

    def ge key, value
      self.params.push("#{key}::ge(#{value})")
    end

    def le key, value
      self.params.push("#{key}::le(#{value})")
    end

    def between key, range_ini, range_end
      self.params.push("#{key}::bt(#{range_ini},#{range_end})")
    end

    def build_uri
      url = ""
      url += url.include?('?') ? "&" : "?"
      url += "filters=#{self.params.join("|")}" unless self.params.empty?
      if self.params.empty? && !self.query.nil?
        url += "#{self.query}" unless self.query.nil?
      else
        url += "&#{self.query}" unless self.query.nil?
      end
      url
    end

  end
end
