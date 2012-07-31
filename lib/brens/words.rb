module Brens
  class Words
    attr_reader :words

    def initialize(words_arr = [])
      @words = words_arr.uniq
    end

    def <<(word)
      word = word.to_s
      @words << word unless words.index(word)

      self
    end

    # Don't add words that are already listed
    def +(words_arr)
      @words = @words | words_arr

      self
    end

    # If passed a String, returns Float index
    #   of the String or nil if not found
    # If passed a Float, returns String closest
    #   to index (first if < 0, last if > 1)
    def [](ndx)
      if ndx.is_a?(String)
        @words.index(ndx).to_f / (@words.size - 1)
      else
        @words[(ndx.to_f * (@words.size - 1)).round]
      end
    end
  end
end
