module Brens
  class String < ::String
    attr_reader :words

    # Public: Split on whitespace.
    #
    # Returns an Array.
    def to_a
      @words ||= split(/\s+/)
    end

    # Public: Convert to RubyFann training data.
    # 
    # pl - Phrase length.
    #
    # Returns a Hash. Keys are inputs, values are outputs.
    def to_training_data(pl = 3)
      raise "Too short" if to_a.size < pl + 1

      {}.tap do |io|
        words.each_index do |ndx|
          ins = words[ndx..(ndx + (pl - 1))]
          out = words[ndx + pl]

          if ins.size == pl && !out.nil?
            io[ins] = [out]
          end
        end
      end
    end

    # TODO -- spec/doc
    def []
      if ndx.is_a?(String)
        words.index(ndx).to_f / (words.size - 1)
      else
        words[(ndx.to_f * (words.size - 1)).round]
      end
    end
  end
end
