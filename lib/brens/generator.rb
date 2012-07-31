module Brens
  class Generator
    attr_reader :texts, :words

    def initialize(opts = {})
      opts = { phrase_length: 3 }.merge(opts)

      @brain         = Brain.new
      @phrase_length = opts.delete(:phrase_length)
      @texts         = []
    end

    def add_text(str)
      if !texts.index(str)
        @texts << str

        texts.map {|t| whitespace_split(t) }.each do |text|
          @words ||= Words.new
          @words += text

          inputs  = [] 
          outputs = []

          text = usable_words(text)

          text.each_index do |ndx|
            # slice of words @phrase_length-long starting at index
            input = text[ndx..(ndx + (@phrase_length - 1))].map {|w| words[w] }
            inputs << input

            # word following the slice
            output = words[text[ndx + @phrase_length]]
            outputs << [output] unless output.nil?
          end

          @brain.train(inputs, outputs)
        end
      end
    end

    def generate(iters)
      pl = @phrase_length

      (1..iters).inject(rand_phrase) {|text, n|
        text + @brain.run(text[-pl..pl]).map {|ndx| words[ndx] }
      }
    end

    private
      def whitespace_split(str)
        str.split(/\s+/)
      end

      # Returns a @phrase_length-long array of words selected
      # randomly from @texts
      def rand_phrase
        text  = texts[(rand * texts.length).to_i]
        words = whitespace_split(text)

        start_ndx = (rand * (words.size - @phrase_length)).to_i
        words[start_ndx..(start_ndx + (@phrase_length - 1))]
      end

      def usable_words(text)
        num_phrases = text.size / @phrase_length
        end_ndx     = num_phrases * @phrase_length

        text[0..end_ndx]
      end
  end
end
