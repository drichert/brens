module Brens
  class Wordlist < Array
    def initialize(words_arr)
      super(words_arr.uniq)
    end

    def <<(word)
      super(word) unless index(word)
    end

    def +(words_arr)
      # Don't add words that are already listed
      super(words_arr - self)
    end

    # If passed a String, returns Float index
    #   of the String or nil if not found
    # If passed a Float, returns String closest
    #   to index (first if < 0, last if > 1)
    def [](ndx)
      if ndx.is_a?(String)
        index(ndx).to_f / (size - 1)
      else
        super((ndx.to_f * (size - 1)).round)
      end
    end
  end
end
