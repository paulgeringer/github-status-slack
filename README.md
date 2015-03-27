# GithubStatusSlack

A super simple gem that actively checks status.github.com and posts a message to slack when it's updated.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'github_status_slack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_status_slack

## Usage

`ruby bin/github_status_slack --webhook-url=<SLACK URL> &`

## Contributing

1. Fork it ( https://github.com/[my-github-username]/github_status_slack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
