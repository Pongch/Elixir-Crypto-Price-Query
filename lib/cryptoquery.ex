defmodule Cryptoquery do
  @moduledoc """
  Documentation for Cryptoquery.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cryptoquery.hello
      :world

  """
  def hello do
    :world
  end

  #this function spawns more workers and asynchronously fetch API for each crypto
  def rates_for(currencies, crypto) do
    case crypto do
      "BTC" ->
        currencies
        |> Enum.each(fn currency ->
          spawn(Cryptoquery.Bitcoin, :rate_for, [currency])
        end)
      "ETH" ->
        currencies
        |> Enum.each(fn currency ->
          spawn(Cryptoquery.Ethereum, :rate_for, [currency])
        end)
      "OMG" ->
        currencies
        |> Enum.each(fn currency ->
          spawn(Cryptoquery.Omisego, :rate_for, [currency])
        end)
      _ -> "Sorry We only accept ETH and BTC at the moment"
    end
  end



end
