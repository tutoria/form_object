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

  field :date, :date

  field :time, :time

  field :boolean1, :boolean
  field :boolean2, :boolean

  field :string, :string

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

  def test_integer_assignment
    form_object = TestFormObject.new(integer: 5)
    assert_equal 5, form_object.integer    
  end

  def test_string_to_integer_conversion
    params = {
      "integer" => "5"
    }    

    form_object = TestFormObject.new(params)
    assert_equal 5, form_object.integer
  end  

  def test_float_assignment
    form_object = TestFormObject.new(float: 1.234)
    assert_equal 1.234, form_object.float
  end

  def test_string_to_float_conversion
    params = {
      "float" => "1.234"
    }    

    form_object = TestFormObject.new(params)
    assert_equal 1.234, form_object.float
  end

  def test_datetime_assignment
    datetime = DateTime.new(2015, 2, 12, 1, 2, 3)
    form_object = TestFormObject.new(datetime: datetime)
    assert_equal datetime, form_object.datetime
  end

  def test_date_to_datetime_conversion
    date = Date.new(2015, 2, 12)
    form_object = TestFormObject.new(datetime: date)
    assert_equal date.to_datetime, form_object.datetime
  end

  def test_time_to_datetime_conversion
    time = Time.new(2015, 2, 12, 1, 2, 3)
    form_object = TestFormObject.new(datetime: time)
    assert_equal time.to_datetime, form_object.datetime
  end

  def test_string_to_datetime_conversion
    params = {
      "datetime(1i)" => "2015",
      "datetime(2i)" => "2",
      "datetime(3i)" => "12",
      "datetime(4i)" => "1",
      "datetime(5i)" => "2",
      "datetime(6i)" => "3"      
    }    

    form_object = TestFormObject.new(params)
    assert_equal DateTime.new(2015, 2, 12, 1, 2, 3), form_object.datetime
  end

  def test_date_assignment
    date = Date.new(2015, 2, 12)
    form_object = TestFormObject.new(date: date)
    assert_equal date, form_object.date
  end

  def test_datetime_to_date_conversion
    datetime = DateTime.new(2015, 2, 12, 1, 2, 3)
    form_object = TestFormObject.new(date: datetime)
    assert_equal datetime.to_date, form_object.date
  end

  def test_time_to_date_conversion
    time = Time.new(2015, 2, 12, 1, 2, 3)
    form_object = TestFormObject.new(date: time)
    assert_equal time.to_date, form_object.date
  end

  def test_time_to_datetime_conversion
    time = Time.new(1, 2, 3)
    form_object = TestFormObject.new({ "datetime" => time })
    assert_equal time.to_datetime, form_object.datetime
  end

  def test_string_to_date_conversion
    params = {
      "date(1i)" => "2015",
      "date(2i)" => "2",
      "date(3i)" => "12",
    }    

    form_object = TestFormObject.new(params)
    assert_equal Date.new(2015, 2, 12), form_object.date
  end

  def test_time_assignment
    time = Time.new(1, 2, 3)
    form_object = TestFormObject.new(time: time)
    assert_equal time, form_object.time
  end

  def test_date_to_time_conversion
    date = Date.new(2015, 2, 12)
    form_object = TestFormObject.new(time: date)
    assert_equal date.to_time, form_object.time
  end

  def test_datetime_to_time_conversion
    datetime = DateTime.new(2015, 2, 12, 1, 2, 3)
    form_object = TestFormObject.new(time: datetime)
    assert_equal datetime.to_time, form_object.time
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

  def test_boolean_assignment
    form_object = TestFormObject.new(boolean1: true, boolean2: false)
    assert_equal true, form_object.boolean1
    assert_equal false, form_object.boolean2
  end

  def test_string_boolean_conversion
    params = {
      "boolean1" => "yes",
      "boolean2" => "no"
    }    

    form_object = TestFormObject.new(params)
    assert_equal true, form_object.boolean1
    assert_equal false, form_object.boolean2
  end

  def test_string_conversion
    params = {
      "string" => "value",
      "boolean2" => "no"
    }    

    form_object = TestFormObject.new(params)
    assert_equal "value", form_object.string
  end
end  
