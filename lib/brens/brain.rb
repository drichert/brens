module Brens
  class Brain
    def initialize(params = {})
      params = {
        :num_inputs     => 3,
        :hidden_neurons => [2, 8, 4, 3, 4],
        :num_outputs    => 1
      }.merge(params)

      @brain = ::RubyFann::Standard.new(params)
    end

    def train(inputs, outputs)
      training_data = ::RubyFann::TrainData.new(
        :inputs          => inputs,
        :desired_outputs => outputs
      )

      @brain.train_on_data(training_data, 1000, 1, 0.1)
    end

    def run(*inputs)
      @brain.run(inputs)
    end

    def reset(params = {})
      initialize(params)
    end
  end
end
