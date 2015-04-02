require 'minitest/autorun'
require 'monit'

class MonitTest < Minitest::Test
  def test_english_hello
    assert_equal "Hello world!",
      Monit.hi
  end
end
