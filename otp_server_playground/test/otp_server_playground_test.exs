defmodule OtpServerPlaygroundTest do
  use ExUnit.Case
  doctest OtpServerPlayground

  test "greets the world" do
    assert OtpServerPlayground.hello() == :world
  end
end
