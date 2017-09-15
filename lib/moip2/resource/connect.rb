module Moip2
  module Resource
    class Connect < SimpleDelegator
      def initialize(response)
        super(response)
      end
    end
  end
end
