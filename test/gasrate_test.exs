defmodule GasolinePriceTest do
  use ExUnit.Case

  test "Fetch National Average" do
    {status, _} = GasolinePrice.fetch_national_avg()

    assert status == :ok
  end

  test "Fetch Average Rate (AZ)" do
    {status, _} = GasolinePrice.fetch_avg_rates("az")

    assert status == :ok
  end
end
