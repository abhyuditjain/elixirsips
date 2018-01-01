defmodule PingPong do
  @moduledoc """
  Documentation for PingPong.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PingPong.hello
      :world

  """
  def hello do
    :world
  end

  def start() do
    loop()
  end
  
  def loop do
    receive do
      {:pong, from} -> 
        IO.puts "ping -->"
        :timer.sleep 500
        send(from, {:ping, self()})
      {:ping, from} -> 
        IO.puts "    <-- pong"
        :timer.sleep 500
        send(from, {:pong, self()})
    end
    loop()
  end
end
