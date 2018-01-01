defmodule UpcaseProcess do
  @moduledoc """
  Documentation for UpcaseProcess.
  """

  @doc """
  Hello world.

  ## Examples

      iex> UpcaseProcess.hello
      :world

  """
  def hello do
    :world
  end

  def start() do
    pid = spawn(UpcaseProcess, :loop, [])
    {:ok, pid}
  end

  def loop() do
    receive do
      {from, {:upcase, ref, str}} -> 
        send(from, {:ok, ref, String.upcase(str)})
    end
    loop()
  end

  def upcase(pid, str) do
    ref = make_ref()
    send(pid, {self(), {:upcase, ref, str}})
    receive do
      {:ok, ^ref, str} -> {:ok, str}
    end
  end
end
