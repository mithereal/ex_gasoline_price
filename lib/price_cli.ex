if Mix.env() == :cli do
  defmodule GasolinePrice.Cli do
    use Bakeware.Script

    @impl Bakeware.Script
    def main([]) do
      GasolinePrice.fetch_national_avg!()
      |> IO.puts()
    end

    def main(args) do
      args
      |> parse_args()
      |> response()
      |> IO.puts()
    end

    defp parse_args(args) do
      {opts, word, _} =
        args
        |> OptionParser.parse(switches: [fetch_metro_rates: :boolean])

      {opts, List.to_string(word)}
    end

    defp response({opts, state}) do
      {status, msg} =
        case Enum.count(opts) > 1 do
          true ->
            GasolinePrice.fetch_metro_rates(state)

          false ->
            GasolinePrice.fetch_avg_rates(state)
        end

      case status do
        :ok -> Jason.encode!(msg)
        _ -> "Invalid State Code"
      end
    end
  end
end
