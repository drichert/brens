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
          ins  = words[ndx..(ndx + (pl - 1))].map {|w| self[w] }
          outs = [words[ndx + pl]].compact.map {|w| self[w] }

          if ins.size == pl && !outs.empty?
            io[ins] = outs
          end
        end
      end
    end

    def [](ndx)
      if ndx.is_a?(Float)
        to_a[(ndx.to_f * (to_a.size - 1)).round]
      else
        to_a.index(ndx.to_s).to_f / (to_a.size - 1)
      end
    end
  end
end
