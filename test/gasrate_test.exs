defmodule GasrateTest do
  use ExUnit.Case

  test "Fetch National Average" do
    {status, _} = Gasrate.fetch_national_avg()

    assert status == :ok
  end
end
