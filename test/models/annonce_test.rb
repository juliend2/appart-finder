require 'test_helper'

class AnnonceTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true

  test "un titre c't'un titre" do
    assert_equal '1 1/2 à montréal', @un.title
  end

  test "size" do
    assert_equal 1.5, Annonce.size('1 1/2')
    assert_equal 2.5, Annonce.size('2 ½')
    assert_equal 3.5, Annonce.size('3½')
    assert_equal 2.5, @ptit.size
  end

  test "french" do
    assert_equal 1.5, Annonce.size("Un 1 et demi !")
    assert_equal 1.5, Annonce.size("1 et demie")
  end

  test "floats" do
    assert_equal 1.5, Annonce.size("1.5")
  end
end
