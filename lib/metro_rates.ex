defmodule MetroRates do
  @moduledoc false

  @derive Jason.Encoder
  defstruct metro: nil
end

defmodule MetroRates.Period do
  @moduledoc false
  @derive Jason.Encoder
  defstruct period: nil,
            rates: nil
  end