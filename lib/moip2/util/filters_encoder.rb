module Moip2
  module Util
    class FiltersEncoder
      def self.encode(filters)
        return nil unless filters.is_a? Hash

        encoded_filters = filters.map do |field, value|
          rules = extract_rules(field, value)
          rules.join("|")
        end

        encoded_filters.join("|")
      end

      private

      def self.extract_rules(field, rules)
        rules.map do |type, value|
          return unless %i[gt ge lt le bt in].include?(type)

          content = value.is_a?(Array) ? value.join(",") : value

          "#{field}::#{type}(#{content})"
        end
      end
    end
  end
end