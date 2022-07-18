defmodule GasolinePrice do
  @moduledoc """
  Documentation for GasolinePrice.
  """

  alias GasolinePrice.Http

  @spec fetch_national_avg :: {:ok, float}
  @doc """
  Fetch National Avg.

  ## Examples

      iex> GasolinePrice.fetch_national_avg
      {:ok, 2.273}

  """

  def fetch_national_avg do
    {_, response} = Http.state_gas_price_averages()

    html = response.body

    {:ok, html} = Floki.parse_document(html)

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

      iex> GasolinePrice.fetch_avg_rates("AZ")
      %{diesel: 2.89, mid: 2.669, premium: 2.877, regular: 2.447}

  """

  def fetch_avg_rates(state) do
    {_, response} = Http.fetch_avg_rates(state)

    html = response.body

    {:ok, html} = Floki.parse_document(html)

    result = Floki.find(html, "table.table-mob")

    result = List.first(result)

    {_, _, avg} = result

    [_, body] = avg

    {_, _, res} = body

    [current, _, _, _, _] = res

    {_, _, rate_list} = current

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

      iex> GasolinePrice.fetch_avg_rates!("AZ")
       %{diesel: 2.89, mid: 2.669, premium: 2.877, regular: 2.447}

  """
  def fetch_avg_rates!(state) do
    rates = fetch_avg_rates(state)
    {_, rates} = rates
    rates
  end

  @doc """
  Fetch National Avg.

  ## Examples

      iex> GasolinePrice.fetch_national_avg!
      2.273

  """
  def fetch_national_avg!() do
    rates = fetch_national_avg()
    {_, rates} = rates
    rates
  end

  @doc """
  Fetch Metro Rates.

      iex> GasolinePrice.fetch_metro_rates("AZ")
      {:ok, []}
  """

  def fetch_metro_rates(state, rate_area \\ :all) do
    {_, response} = Http.fetch_avg_rates(state)

    html = response.body

    {:ok, html} = Floki.parse_document(html)

    [{"div", [{"class", "accordion-prices metros-js"}], data}] =
      Floki.find(html, ".accordion-prices")

    rates =
      Enum.chunk_every(data, 2)
      |> Enum.map(fn [key, values] ->
        {_, _, [area]} = key

        [{_, _, data}] = Floki.find(values, "table.table-mob")

        [{_, _, newlist}] = List.delete_at(data, 0)

        Enum.map(newlist, fn x ->
          {_, _, rates} = x

          {_, _, [type]} = List.first(rates)

          rates =
            List.delete_at(rates, 0)
            |> Enum.map(fn {_, _, [rate]} ->
              String.replace(rate, "$", "")
              |> String.trim()
              |> String.to_float()
            end)

          rates = %{
            regular: Enum.at(rates, 0),
            mid: Enum.at(rates, 1),
            premium: Enum.at(rates, 2),
            diesel: Enum.at(rates, 3)
          }

          {String.downcase(area), rates, String.downcase(type)}
        end)
      end)
      |> Enum.map(fn rates ->
        data =
          Enum.map(rates, fn x ->
            {_, rates, time} = x
            %{period: time, rates: rates}
          end)

        %{metro: data}
      end)

    rates =
      case(rate_area) do
        :all -> rates
        area -> Keyword.get(rates, area)
      end

    {:ok, rates}
  end
end
