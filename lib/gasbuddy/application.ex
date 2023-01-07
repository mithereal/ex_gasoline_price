defmodule GasolinePrice.GasBuddy.Application do
  @moduledoc false

  use Application

  require Logger

  alias GasolinePrice.GasBuddy.LastUpdated
  alias GasolinePrice.GasBuddy.Server.HealthyCheck
  alias GasolinePrice.GasBuddy.Server.UnHealthyCheck
  alias GasolinePrice.GasBuddy.Server.DeadCheck

  @impl true
  def start(_type, _args) do

    maybe_loaded_children =
      case is_nil(System.get_env("EX_GASOLINE_RATE_TEST")) do
        true ->
          [{HealthyCheck, []}, {UnHealthyCheck, []}, {DeadCheck, []}]

        false ->
          Logger.info("Skipping sync job setup...")
          []
      end

    children =
      [
        {LastUpdated, DateTime.utc_now()},
        {DynamicSupervisor, strategy: :one_for_one, name: :service_supervisor},
        {Registry, keys: :unique, name: :service},
        {Registry, keys: :duplicate, name: :status, partitions: System.schedulers_online()}
      ] ++ maybe_loaded_children

    opts = [strategy: :one_for_one, name: GasolinePrice.GasBuddy.Supervisor]

    Supervisor.start_link(children, opts)
  end

end
