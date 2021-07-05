# Piper.rb

## Installation

Add this line to your application's Gemfile:

```ruby
gem "piper-rb"
```

## Usage

### Super basic

The most basic element of `Piper` is a `pipe`.
Just think of it as a condition step. If no keywords are used, then (in accordance to Ruby
conventions) the last line of code is taken as the step's condition:

```ruby
require "piper-rb"

class YourSuperbService < PiperService
  attribute :input, Types::Any

  pipe "input is Numeric" do
    input.is_a? Numeric
  end

  pipe "input is greater than 100?" do
    false

    200 == 100

    input > 100
  end

  pipe "input is less than 1000?" do
    input < 1000
  end
end

YourSuperbService.new(input: 200).call
#=> Success(true)

YourSuperbService.new(input: "asd").call
#=> Failure({:service=>#<YourSuperbService input="asd">, :object=>false, :message=>nil})

```

### Keywords for more control

If you want to specify the condition, object to be returned and the error message, there are
keywords for this:

* `condition` (aliase: `cond`)
* `result_object` (aliases: `object`, `rslt`)
* `message` (aliases: `fail_message`, `mssg`)


```ruby
require "piper-rb"

class YourFineService < PiperService
  attribute :input, Types::Any

  pipe "input is Numeric" do
    message { "The input must be `Numeric`." }

    input.is_a? Numeric
  end

  pipe "input is greater than 100?" do
    cond { input > 100 }

    200 == 100
  end

  pipe "input is less than 1000?" do
    object { input }

    input < 1000
  end
end

YourFineService.new(input: 200).call
#=> Success(200)

YourFineService.new(input: "asd").call
#=> Failure({:service=>(...), :object=>false, :message=>"The input must be `Numeric`."})

```

### You can access last step's object with `last_result`:

```ruby
require "piper-rb"

class YourGreatService < PiperService
  attribute :input, Types::Any

  pipe "this step`s result should be passed to..." do
    input * 30
  end

  pipe "...to this step" do
    cond    { last_result == input * 30 }
    object  { last_result }
  end
end

YourGreatService.new(input: 20).call
#=> Success(600)
```

### You can nest services, calling them in a pipe passes their result:

```ruby
require "piper-rb"

class YourMajesticService < PiperService
  attribute :input, Types::Any

  pipe :nothing_to_see_here do
    true
  end

  pipe :calling_nested_service do
    YourFlamboyantService.new(nested_input: input * 20).call
  end
end

class YourFlamboyantService < PiperService
  attribute :nested_input, Types::Any

  pipe :simple_step do
    message { "I am the one who knocks!" }
    nested_input >= 300
  end

end

YourMajesticService.new(input: 20).call
#=> Success(true)

YourMajesticService.new(input: 2).call
#=> Failure({:service=>#<YourFlamboyantService nested_input=40>, :object=>false, :message=>"I am the one who knocks!"})
```

---

### You can configure default `nil` behavior.

By default, pipes fail when they end in `nil` and do not handle exceptions.
You can, of course, explicitly return `true` in order to make sure a pipe is successful, even if it ended in `nil`.


But in 0.4 you now have an option to tweak the default behavior, by using `pass_nil`. Bear in mind this option is inherited, so if your services inherit from, say, `BaseService`, then this - unless overwritten in a given service – will affect all services:

Refer to [specs](https://github.com/ellmo/piper-rb/blob/master/spec/service/configured_service_spec.rb) for more info.

```ruby
require "piper-rb"

class BaseService < PiperService
  pass_nil true

  # [...]
end
```
