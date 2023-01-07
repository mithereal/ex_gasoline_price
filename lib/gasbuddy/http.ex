defmodule GasolinePrice.GasBuddy.Http do
## start a set of tasks to connect via proxy to gasbuddy station urls 1 ... 119999 so we dont overload of raise sus that that were a bot we should have a config that specifies how many servers to max spawn and balance/ fetch time delay, start some channels that wait for ppl to subscribe before we add the autofetch, we only want to fetch station/name at the beginnung and build a db of uuid key name stations

  @moduledoc false
  use Tesla
  use GenServer

  plug(Tesla.Middleware.BaseUrl, "https://www.gasbuddy.com/station/")

@last_station_id 119999

def fetch_station(id, proxy) do
    cli = Tesla.build_client([{Tesla.Middleware.Opts, adapter: [proxy: proxy]}])
    Tesla.get!(cli, "https://www.gasbuddy.com/station/#{id}}").body
end

def fetch_station(id) do
    get("/#{id}")
end

  def check_top_station() do
    get("/#{@last_station_id}")
  end

  def init(_) do

  end
  def init(_) do

  end


def fetch_stations() do
    max_tasks = Application.get_env(:gasoline_price, :max_tasks, 15)
    proxies = Application.get_env(:gasoline_price, :proxies, [])
## do similiar to farside with ets, and fetch regestrys
end

def extract_prices(data) do
    prices = []
    {:ok, prices}
end
end

def Application do
{Registry, keys: :unique, name: :user_registry},
end