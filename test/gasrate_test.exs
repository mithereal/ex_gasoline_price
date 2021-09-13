defmodule GasrateTest do
  use ExUnit.Case

  test "Fetch National Average" do
    {status, _} = Gasrate.fetch_national_avg()

    assert status == :ok
  end

  test "Fetch Average Rate (AZ)" do
    {status, _} = Gasrate.fetch_avg_rates("az")

    assert status == :ok
  end
end
