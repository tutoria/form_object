require 'minitest/autorun'
require 'form_object'

class TestFormObject
  include FormObject::Mixin

  field :reader, :integer, attr: :reader

  field :writer, :integer, attr: :writer

  field :accessor, :integer, attr: :accessor

  field :integer, :integer

  field :float, :float

  field :datetime, :datetime

  field :time, :time

  def initialize(form_params)
    assign_fields(form_params)
  end
end

class FormObjectTest < Minitest::Test
  def test_generates_reader
    @test_form_object = TestFormObject.new({})
    assert_equal nil, @test_form_object.reader
  end

  def test_generates_writer
    @test_form_object = TestFormObject.new({})
    @test_form_object.writer = 123
  end

  def test_generates_accessor
    @test_form_object = TestFormObject.new({})
    assert_equal nil, @test_form_object.accessor
    @test_form_object.accessor = 123
  end

  def test_string_integer_conversion
    params = {
      "integer" => "5"
    }    

    form_object = TestFormObject.new(params)
    assert_equal 5, form_object.integer
  end

  def test_string_float_conversion
    params = {
      "float" => "1.234"
    }    

    form_object = TestFormObject.new(params)
    assert_equal 1.234, form_object.float
  end

  def test_string_datetime_conversion
    params = {
      "datetime(1i)" => 2015,
      "datetime(2i)" => 2,
      "datetime(3i)" => 12,
      "datetime(4i)" => 1,
      "datetime(5i)" => 2,
      "datetime(6i)" => 3      
    }    

    form_object = TestFormObject.new(params)
    assert_equal DateTime.new(2015, 2, 12, 1, 2, 3), form_object.datetime
  end

  def test_string_time_conversion
    params = {
      "time(4i)" => 1,
      "time(5i)" => 2,
      "time(6i)" => 3      
    }    

    form_object = TestFormObject.new(params)
    assert_equal Time.new(1, 2, 3), form_object.time
  end
end  
