[dryrb]: https://dry-rb.org

# dry-service

#### disclaimer
_Not_ a part of [dry-rb][dryrb].


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-service', git: 'https://github.com/ellmo/dry-service.git'
```

## Usage

### super basic

The most basic element of the `DryService` is a `pipe`.
Just think of it as a condition step. If no keywords are used, then (in accordance to Ruby
conventions) the last line of code is taken as the step's condition:

```ruby
require "dry-service"

class YourSuperbService < DryService
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

### keywords for more control

If you want to specify the condition, object to be returned and the error message, there are
keywords for this:

* `cond`
* `object`
* `message`


```ruby
require "dry-service"

class YourFineService < DryService
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

### you can access last step's object with `last_result`:

```ruby
require "dry-service"

class YourGreatService < DryService
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

### you can nest services, calling them in a pipe passes their result:

```ruby
require "dry-service"

class YourMajesticService < DryService
  attribute :input, Types::Any

  pipe :nothing_to_see_here do
    true
  end

  pipe :calling_nested_service do
    YourFlamboyantService.new(nested_input: input * 20).call
  end
end

class YourFlamboyantService < DryService
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
