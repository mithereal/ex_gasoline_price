defmodule Gasrate.Http do
  @moduledoc false
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://gasprices.aaa.com")

  def state_gas_price_averages() do
    get("/state-gas-price-averages/")
  end

  def fetch_avg_rates(state) do
    get("?state=" <> state)
  end
end
