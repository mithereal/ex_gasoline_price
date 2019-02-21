defmodule Gasrate do
  @moduledoc """
  Documentation for Gasrate.
  """
  @url "https://gasprices.aaa.com/"

  @doc """
  Fetch National Avg.

  ## Examples

      iex> Gasrate.fetch_national_avg
      {:ok, _}

  """

  def fetch_national_avg do
    response = HTTPotion.get(@url <> "state-gas-price-averages/")

    html = response.body

    [result] = Floki.find(html, "p.numb")

    {_, _, avg} = result

    avg = List.first(avg)

    avg = String.replace(avg, "$", "")

    avg = String.trim(avg)

    response = String.to_float(avg)

    {:ok, response}
  end

  @doc """
  Fetch Rates.

  ## Examples

      iex> Gasrate.fetch_avg_rates("AZ")
      {:ok, %{diesel: _, mid: _, premium: _, regular: _}}

  """

  def fetch_avg_rates(state) do
    response = HTTPotion.get(@url <> "?state=" <> state)

    html = response.body

    result = Floki.find(html, "table.table-mob")

    result = List.first(result)

    {_, _, avg} = result

    [head, body] = avg

    {_, _, res} = body

    [current, yesterday, lastweek, lastmonth, lastyear] = res

    {_, _, rate_list} = current

    first = List.first(rate_list)

    {_, _, name_list} = first

    name = List.first(name_list)

    newlist = List.delete_at(rate_list, 0)

    rates =
      Enum.map(newlist, fn x ->
        {_, _, name_list} = x
        rate = List.first(name_list)

        rate = String.replace(rate, "$", "")

        rate = String.trim(rate)

        String.to_float(rate)
      end)

    rates = %{
      regular: Enum.at(rates, 0),
      mid: Enum.at(rates, 1),
      premium: Enum.at(rates, 2),
      diesel: Enum.at(rates, 3)
    }

    {:ok, rates}
  end

  @doc """
  Fetch Rates.

  ## Examples

      iex> Gasrate.fetch_avg_rates!("AZ")
      %{diesel: _, mid: _, premium: _, regular: _}

  """
  def fetch_avg_rates!(state) do
    rates = fetch_avg_rates(state)
    {_, rates} = rates
    rates
  end

  @doc """
  Fetch National Avg.

  ## Examples

      iex> Gasrate.fetch_national_avg!
      _

  """
  def fetch_national_avg!() do
    rates = fetch_national_avg()
    {_, rates} = rates
    rates
  end

end
