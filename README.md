# form_object

The form_object gem initializes plain old Ruby classes using a params
hash coming from a Rails HTML form:

```ruby
event = Event.new({
  "repetitions" => "5".
  "date(1i)" => "1",
  "date(2i)" => "1",
  "date(3i)" => "2015"
})

event.repetitions # => 5
event.date # => Thu, 01 Jan 2015
```

Where Event is defined as follows:

```ruby
class Event
  include FormObject::Mixin

  field :date, :date
  field :repetitions, :integer

  def initialize(form_params)
    assign_fields(form_params)
  end
end
```

Compared to other similar projects, it has a very simple, unobtrusive
design:

  * it is not tied to ActiveRecord::Base internals
 
  * it depends on only one other gem: activesupport

  * it injects only one class method and one instance method into your
    Ruby class

## Setup

Add:

```ruby
gem 'form_object'
```

to your Gemfile.