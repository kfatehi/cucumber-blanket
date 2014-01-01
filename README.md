# Cucumber::Blanket

**WIP** -- will be done soon though, it's close, I just need to complete
the report generator

Works to extract [Blanket.js](https://github.com/alex-seville/blanket) coverage data 
from the browser from Cucumber.

## Installation

Add this line to your application's Gemfile:

    gem 'cucumber-blanket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber-blanket

## Usage

You should be using Cucumber

Require this gem at the top of `features/support/env.rb` or before using it.

```ruby
require 'cucumber/blanket'
```

Install blanket.js

Two javascript files are bundled;
* blanket.js -- the library itself
* cucumber-blanket.js -- a very simple modification

These two files must be loaded on the front-end --- be sure to follow
blanket.js's specifications (you must add the attribute `data-cover` to
any scripts you want blanket.js to instrument)

cucumber-blanket.js initiates a coverage report session -- you are
expected to complete the session from the Cucumber side. In this design,
we make use of Cucumber's After hook: 

```ruby
After do |scenario|
  # Grab code coverage from the frontend
  # Currently this adds >1 second to every scenario, but it's worth it
  Cucumber::Blanket.extract_from page
end
```

Of course every scenario will touch on different parts of your code, as
such Cucumber::Blanket OR's the lines. In other words, if line 10 of
File A was covered in Scenario X, but not in Scenario Y, line 10 is
considered covered when Cucumber has finished running.

Finally, to generate a report **not done yet**, you can do:

```ruby
after_exit do
  puts Cucumber::Blanket.generate_report
end
```

I have both of these in my `features/support/hooks.rb` file.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
