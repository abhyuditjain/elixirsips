defmodule StatefulProcessesTest do
  use ExUnit.Case
  doctest StatefulProcesses

  test "greets the world" do
    assert StatefulProcesses.hello() == :world
  end

  test "starts the Counter" do
  	{:ok, pid} = Counter.start(0)
  	assert is_pid(pid)
  end

  test "getting the value" do
  	{:ok, pid} = Counter.start(0)
  	assert {:ok, 0} = Counter.get_value(pid)
  end

  test "increments the counter" do
  	{:ok, pid} = Counter.start(0)
  	:ok = Counter.increment(pid)
  	assert {:ok, 1} = Counter.get_value(pid)
  end

  test "decrements the counter" do
  	{:ok, pid} = Counter.start(2)
  	:ok = Counter.decrement(pid)
  	assert {:ok, 1} = Counter.get_value(pid)
  end

  test "starts the CounterAgent" do
  	{:ok, pid} = CounterAgent.start(0)
  	assert is_pid(pid)
  end

  test "getting the value CounterAgent" do
  	{:ok, pid} = CounterAgent.start(0)
  	assert {:ok, 0} = CounterAgent.get_value(pid)
  end

  test "increments the CounterAgent" do
  	{:ok, pid} = CounterAgent.start(0)
  	:ok = CounterAgent.increment(pid)
  	assert {:ok, 1} = CounterAgent.get_value(pid)
  end

  test "decrements the CounterAgent" do
  	{:ok, pid} = CounterAgent.start(2)
  	:ok = CounterAgent.decrement(pid)
  	assert {:ok, 1} = CounterAgent.get_value(pid)
  end
end
