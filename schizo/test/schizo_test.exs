defmodule SchizoTest do
  use ExUnit.Case
  doctest Schizo

  test "1st word remains lowercase" do
  	assert Schizo.upcase("foo") == "foo"
  end

  test "2nd word changed to uppercase" do
  	assert Schizo.upcase("foo bar") == "foo BAR"
  end

  test "every other word change to uppercase" do
  	assert Schizo.upcase("foo bar baz whee") == "foo BAR baz WHEE"
  end

  test "1st word remains upchanged" do
  	assert Schizo.unvowel("foo") == "foo"
  end

  test "2nd word changed" do
  	assert Schizo.unvowel("foo bar") == "foo br"
  end

  test "every other word change" do
  	assert Schizo.unvowel("foo bar baz whee") == "foo br baz wh"
  end
end
