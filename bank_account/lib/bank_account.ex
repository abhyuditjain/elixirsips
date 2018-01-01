defmodule BankAccount do
  @moduledoc """
  Documentation for BankAccount.
  """

  def start do
    loop([])
  end

  def loop(events) do
    receive do
      {:check_balance, from} -> divulge_balance(from, events)
      {:deposit, amount} -> events = deposit(events, amount)
      {:withdraw, amount} -> events = withdraw(events, amount)
    end
    loop(events)
  end
  
  defp deposit(events, amount) do
    events ++ [{:deposit, amount}]
  end

  defp withdraw(events, amount) do
    events ++ [{:withdrawal, amount}]
  end

  defp divulge_balance(from, events) do
    send(from, {:balance, calculate_balance(events)})
  end

  defp calculate_balance(events) do
    deposits = sum(just_deposits(events))
    withdrawals = sum(just_withdrawals(events))
    deposits - withdrawals
  end

  defp just_deposits(events) do
    just_type(events, :deposit)
  end

  defp just_withdrawals(events) do
    just_type(events, :withdrawal)
  end

  defp just_type(events, expected_type) do
    Enum.filter(events, fn({type, _}) -> type == expected_type end)
  end
  
  defp sum(events) do
    Enum.reduce(events, 0, fn({_, amount}, acc) -> acc + amount end)
  end
end
