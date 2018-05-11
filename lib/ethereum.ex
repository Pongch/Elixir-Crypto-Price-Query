defmodule Cryptoquery.Ethereum do
  @api_url Application.fetch_env!(:cryptoquery, :eth_url)

  def rate_for(currency) do
    rate =
      currency
      |> url_for()
      |> HTTPoison.get()
      |> parse_response()
      |> get_rate(currency)

    response = case rate do
      {:ok, rate} ->
        "#{rate} #{currency} for 1 ETH"
      :error ->
        "Error occured getting rate for #{currency}"
    end

    IO.puts response
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    Poison.decode!(body)

  end
  defp parse_response(_), do: false

  defp get_rate(json, currency) do
    rate = json[currency]
    {:ok, rate}

  rescue
    _ -> :error
  end

  defp url_for(currency) do
    normalized_currency = currency |> String.trim() |> URI.encode()
    "#{@api_url}#{normalized_currency}"

  end
end
