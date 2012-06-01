# Brens

Brens is an [ANN](http://en.wikipedia.org/wiki/Artificial_neural_network "Artificial Neural Network")-based text generator

## Installation

Add this line to your application's Gemfile:

    gem 'brens'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brens

## Usage

### Words

```ruby
text  = "The quick brown fox jumps over the lazy dog. Hi."
words = Brens::Words.new(text)

words[0.0] #=> "The"
words[0.3] #=> "fox"
words[1.0] #=> "Hi."
```

Convert position value to float index  

```ruby
words.index(9) #=> 1.0
words.index(5) #=> 0.55555
words.index(0) #=> 0.0
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
