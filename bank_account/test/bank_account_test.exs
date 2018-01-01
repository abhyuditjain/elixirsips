defmodule BankAccountTest do
  use ExUnit.Case
  doctest BankAccount

  test "start off with 0 balance" do
    account = spawn_link(BankAccount, :start, [])
    verify_balance_is 0, account
  end

  test "balance incremented by amount deposited" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:deposit, 10})
    verify_balance_is 10, account
  end
  
  test "balance decremented by amount withdrawn" do
    account = spawn_link(BankAccount, :start, [])
    send(account, {:deposit, 20})
    send(account, {:withdraw, 10})
    verify_balance_is 10, account
  end
  
  defp verify_balance_is(expected_balance, account) do
    send(account, {:check_balance, self()})
    assert_receive {:balance, ^expected_balance}
  end
end
