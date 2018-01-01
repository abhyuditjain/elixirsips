defmodule UpcaseProcessTest do
  use ExUnit.Case
  doctest UpcaseProcess

  test "greets the world" do
    assert UpcaseProcess.hello() == :world
  end

  test "it starts the process" do
  	{:ok, pid} = UpcaseProcess.start()
  	assert is_pid(pid)
  end

  test "upcase function with multiple messages" do
  	{:ok, pid} = UpcaseProcess.start
  	assert {:ok, "FOO"} = UpcaseProcess.upcase(pid, "foo")
  	assert {:ok, "BAR"} = UpcaseProcess.upcase(pid, "bar")
  	assert {:ok, "BAZ"} = UpcaseProcess.upcase(pid, "baz")
  end
end
