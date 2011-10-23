require 'test_helper'

class SpikTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Spik
  end

  test "should return first post" do
    include Spik
    find first post
    assert_not_nil @post
  end
end
