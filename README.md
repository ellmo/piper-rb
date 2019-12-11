# A minimalistic template for gembuilding

### Installation

1. `git clone git@github.com:ellmo/anygem.git`
2. `cd anygem`
3. `gem build anygem.gemspec`
4. `gem install anygem-[VERSION].gem`

Now you can load the gem in `irb`/`pry` as usual:

```ruby
require "anygem"
AnyGem::Greeter.hi
```

You now also have an executable in your `sh`/`bash`/`zsh`:

`anygem`

### Development

Experiment all you want.

You can run `rspec` or better yet `bundle exec rspec` while in gem's directory, provided that
a proper version of RSpec was installed via `bundle install`.

There's also a custom `.rubocop.yml` file, which describes some of RuboCop rules I use. This file
can be safely ignored for all development shenanigans, but it's highly recommended to always
use _some_ sort of RuboCop setup.

### Uninstalling

1. `gem uninstall anygem`
2. Remove the directory.
