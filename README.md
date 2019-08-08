# Open3

Open3 gives you access to stdin, stdout, and stderr when running other
programs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open3

## Usage

Open3 grants you access to stdin, stdout, stderr and a thread to wait for the child process when running another program.
You can specify various attributes, redirections, current directory, etc., of the program in the same way as for Process.spawn.

- Open3.popen3 : pipes for stdin, stdout, stderr
- Open3.popen2 : pipes for stdin, stdout
- Open3.popen2e : pipes for stdin, merged stdout and stderr
- Open3.capture3 : give a string for stdin; get strings for stdout, stderr
- Open3.capture2 : give a string for stdin; get a string for stdout
- Open3.capture2e : give a string for stdin; get a string for merged stdout and stderr
- Open3.pipeline_rw : pipes for first stdin and last stdout of a pipeline
- Open3.pipeline_r : pipe for last stdout of a pipeline
- Open3.pipeline_w : pipe for first stdin of a pipeline
- Open3.pipeline_start : run a pipeline without waiting
- Open3.pipeline : run a pipeline and wait for its completion

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ruby/open3.
