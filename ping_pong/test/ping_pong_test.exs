defmodule PingPongTest do
  use ExUnit.Case
  doctest PingPong

  test "greets the world" do
    assert PingPong.hello() == :world
  end

  test "it responds to a pong with a ping" do
    ping = spawn(PingPong, :start, [])

    send(ping, {:pong, self()})

    assert_receive {:ping, ^ping}, 1000
  end

  test "it responds to 2 messages" do
    ping = spawn(PingPong, :start, [])

    send(ping, {:pong, self()})
    assert_receive {:ping, ^ping}, 1000
    send(ping, {:pong, self()})
    assert_receive {:ping, ^ping}, 1000
  end
end
