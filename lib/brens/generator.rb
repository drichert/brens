module Brens
  class Generator
    def initialize(opts = {})
      opts = {
        :phrase_length = 3
      }.merge(opts)

      @brain         = Brain.new
      @phrase_length = opts[:phrase_length]
    end

    def add_text(str)
      words = whitespace_split(str)

      @wlist ||= Wordlist.new(words)

      inputs  = []
      outputs = []

      # iterate through each word
      words.each_with_index do |w, ndx|
        # slice of words @phrase_length-long starting at index
        inputs  << words[ndx..(ndx + (@phrase_length - 1))]

        # word following the slice
        outputs << [words[ndx + @phrase_length]]
      end

      @brain.train(inputs, outputs)
    end

    def generate(length)
    end

    private
      def whitespace_split(str)
        str.split(/\s+/)
      end
  end
end
