# Mutants

![ruby](https://github.com/vurokrazia/mutants/actions/workflows/ruby.yml/badge.svg)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mutants`. To experiment with that code, run `bin/console` for an interactive prompt.

This library helps you detect if a DNA sequence belongs to a mutant or not.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add mutants

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install mutants

## Usage

First step is has a sequence DNA:
```ruby
sequence = %w[
    ATAG
    TAAA
    AGAG
    ACAA
]

```
The second step is to create an instance of the validations class with the sequence to validate, activate the flags to evaluate in the case:
```ruby
builder = Mutants::Validations.new
    .set_sequence(
        sequence
    )
    .set_validate_sizes(true)
    .set_validate_dna(true)
```
If you have an invalid sequence by dimension sizes, it returns with this error:
```ruby
    Mutants::Validations::InvalidSizeDnaSequence
```
If you have an invalid sequence due to letters in the DNA AGTC sequence, it returns with this error:
```ruby
    Mutants::Validations::InvalidDNA
```
The las step is pass the builder to dectector class and execute isMutant with the sequence and check the result.
```ruby
Mutants::Detector.new(builder).isMutant(sequence)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mutants. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/mutants/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mutants project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mutants/blob/master/CODE_OF_CONDUCT.md).
