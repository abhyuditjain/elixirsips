defmodule FridgeServer do
  use GenServer

  ### PUBLIC API
  def start_link do
    {:ok, pid} = GenServer.start_link(__MODULE__, [], [])
    pid
  end

  def store(server, item) do
    GenServer.cast(server, {:store, item})
  end

  def take(server, item) do
    GenServer.call(server, {:take, item})
  end

  def init(items) do
    {:ok, items}
  end

  def handle_cast({:store, item}, items) do
    {:noreply, [item | items]}
  end

  def handle_call({:take, item}, _from, items) do
    case Enum.member?(items, item) do
      true ->
        {:reply, {:ok, item}, List.delete(items, item)}
      false ->
        {:reply, :not_found, items}
    end
  end
end

