defmodule CounterAgent do
	def start(initial) do
		Agent.start(fn -> initial end)
	end

	def get_value(pid) do
		Agent.get(pid, fn(x) -> {:ok, x} end)
	end

	def increment(pid) do
		Agent.update(pid, fn(x) -> x + 1 end)
	end

	def decrement(pid) do
		Agent.update(pid, fn(x) -> x - 1 end)
	end
end