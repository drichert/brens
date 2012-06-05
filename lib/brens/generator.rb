module Brens
  class Generator
    def initialize(*texts)
      @brain = Brain.new
    end

    def add_text(str)
      wlist = Wordlist.new(
        whitespace_split(str)
      )
    end

    def generate(length)
    end

    private
      def whitespace_split(str)
        str.split(/\s+/)
      end
  end
end
