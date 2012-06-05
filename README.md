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

```ruby
gen = Brens::Generator.new

# Add source texts
gen.add_text(File.read("text1.txt"))
gen.add_text(File.read("text2.txt"))

# Generate 300 words based on added source texts
gen.generate(300)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
