module Brens
  class Words
    attr_reader :words

    def initialize(str)
      @words = str.split(/\s+/)
    end

    def [](ndx)
      if ndx.is_a?(Float)
        float_index(ndx)
      elsif ndx.is_a?(Integer)
        @words[ndx]
      end
    end

    private
      def float_index(ndx)
        @words[(ndx * (@words.size - 1)).round]
      end

      # position is rounded to int
      #
      # Returns float (0..1) index value
      def index(position)
        position.round.to_f / (@words.size - 1)
      end
  end
end
