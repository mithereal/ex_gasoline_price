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
      |> response()
      |> IO.puts()
    end

    defp parse_args(args) do
      {opts, word, _} =
        args
        |> OptionParser.parse(switches: [fetch_avg_rates: :boolean])

      {opts, List.to_string(word)}
    end

    defp response([state]) do
      {status, msg} = GasolinePrice.fetch_avg_rates(state)

      case status do
        :ok -> Jason.encode!(msg)
        _ -> "Invalid State Code"
      end
    end
  end
end
