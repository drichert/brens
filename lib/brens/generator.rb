module Brens
  class Generator
    attr_reader :texts

    def initialize(opts = {})
      opts = {
        :phrase_length => 3
      }.merge(opts)

      @brain         = Brain.new
      @phrase_length = opts[:phrase_length]
      @texts         = []
    end

    def add_text(str)
      if !texts.index(str)
        @texts << str

        texts.map {|t| whitespace_split(t) }.each do |words|
          @wlist ||= Wordlist.new
          @wlist += words

          i = [] # inputs
          o = [] # outputs

          # iterate through each word
          words.each_with_index do |w, ndx|
            # slice of words @phrase_length-long starting at index
            i << words[ndx..(ndx + (@phrase_length - 1))] #.map {|w| @wlist[w] }

            # word following the slice
            o << [@wlist[words[ndx + @phrase_length]]]
          end

          @brain.train(i, o)
        end
      end
    end

    def generate(iters)
      pl = @phrase_length

      (1..iters).inject(rand_phrase) {|text, n|
        text + @brain.run(text[-pl..pl]).map {|ndx| @wlist[ndx] }
      }

      #text = rand_phrase

      #iters.times do |n|
      #  text += @brain.run(text[-@phrase_length..@phrase_length])
      #end
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
  end
end
