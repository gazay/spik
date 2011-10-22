require 'test_helper'

class SpikeTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Spike
  end

  test "should return first post" do
    include Spike
    find first post
    assert_not_nil @post
  end
end
