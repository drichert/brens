module Brens
  class NN
    def initialize(words, phrase_length = 3)
      raise ArgumentError unless words.is_a?(Words)

      @words         = words
      @phrase_length = phrase_length

      train
    end

    def run(*inputs)
      raise ArgumentError unless inputs.length == @phrase_length

      @nn.run(inputs)
    end

    private
      def train
        inputs  = []
        outputs = []

        @words.words.each_slice(@phrase_length)     {|w| inputs << w }
        @words.words.each_slice(@phrase_length + 1) {|w| outputs << w.last }

        data = ::RubyFann::TrainData.new(
          :inputs          => inputs,
          :desired_outputs => outputs
        )

        @nn = ::RubyFann::Standard.new(
          :num_inputs     => 3,
          :hidden_neurons => [2, 8, 4, 3, 4],
          :num_outputs    => 1
        )

        @nn.train_on_data(data, 1000, 1, 0.1)
      end
  end
end
