defmodule Gasrate.Cli do
  use Bakeware.Script

  @impl Bakeware.Script
  def main([]) do
    Gasrate.fetch_national_avg!()
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
      |> OptionParser.parse(switches: [fetch_avg_rates: :boolean])

    {opts, List.to_string(word)}
  end

  defp response({opts, state}) do
    Gasrate.fetch_avg_rates!(state)
  end
end
