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

    # position can be a number or a string.
    # If position is a number, it is rounded to int.
    #
    # Returns float (0..1) index value.
    # Returns nil if numeric position is out of range
    # or if string is not found in @words
    def index(position)
      if position.is_a?(String)
        position = @words.uniq.index(position)

        return nil if position.nil?
      end

      position.round.to_f / (@words.uniq.size - 1)
    end

    private
      def float_index(ndx)
        @words.uniq[(ndx * (@words.uniq.size - 1)).round]
      end
  end
end
