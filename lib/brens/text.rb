module Brens
  class Text < ::String
    attr_reader   :words
    attr_reader   :training_data
    attr_accessor :phrase_length

    def initialize(str)
      @phrase_length = 3

      super
    end

    # Public: Split on whitespace.
    #
    # Returns an Array.
    def to_a
      @words ||= split_on_whitespace
    end

    # Public: Convert to RubyFann training data.
    #
    # pl - Phrase length.
    #
    # Returns a Hash. Keys are inputs, values are outputs.
    def to_training_data(pl = @phrase_length)
      raise "Too short" if to_a.size < pl + 1

      @training_data ||= {}.tap do |io|
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
      if ndx.is_a?(String)
        to_a.index(ndx)
      else
        to_a[ndx.to_i]
      end
    end

    def split_on_whitespace
      split(/\s+/)
    end

    # TODO: spec/doc
    def rand_phrase
      start_ndx = (rand * (to_a.size - phrase_length + 1)).to_i
      to_a[start_ndx..(start_ndx + (phrase_length - 1))]
    end
  end
end
