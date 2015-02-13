# form_object

The form_object gem initializes plain old Ruby classes using a params
hash coming from a Rails HTML form:

  event = Event.new({
    "repetitions" => "5".
    "date(1i)" => "1",
    "date(2i)" => "1",
    "date(3i)" => "2015"
  })

  event.repetitions # => 5
  event.date # => Thu, 01 Jan 2015

Where Event is defined as follows:

  class Event
    include FormObject::Mixin
  
    form_object_setup do
      field_with_reader :date, :date
      field_with_reader :repetitions, :integer
    end

    def initialize(form_params)
      form_object_assign(form_params)
    end
  end

Compared to other similar projects, it has a very simple, unobtrusive
design:

  * it is not tied to ActiveRecord::Base internals
 
  * it depend on only one other gem: activesupport

  * it injects only one class method and one instance method into your
    Ruby class

## Setup

Add:

  gem 'form_object'

to your Gemfile.

## Quick reference

You can use field_with_reader, field_with_writer or
field_with_accessor to both declare the type of an attribute and
generate an attr_reader, attr_writer or attr_accessor for the instance
variable holding the particular form field.